import 'dart:convert';

import '../../domain/models/micro_step.dart';
import '../../domain/models/task_template.dart';
import '../../domain/repositories/template_repository.dart';
import '../../domain/services/template_service.dart';
import '../database/app_database.dart';

/// Repository that combines bundled asset templates with custom DB templates.
class AssetTemplateRepository implements TemplateRepository {
  final TemplateService _templateService;
  final AppDatabase _db;

  AssetTemplateRepository(this._templateService, this._db);

  @override
  Future<List<TaskTemplate>> getAllTemplates() async {
    final bundled = await _templateService.loadTemplates();
    final custom = await getCustomTemplates();
    final all = [...bundled, ...custom];
    return _populateBlockedBy(all);
  }

  @override
  Future<List<TaskTemplate>> getTemplatesByCategory(String category) async {
    final bundled = await _templateService.getByCategory(category);
    final custom = await getCustomTemplates();
    final filteredCustom =
        custom.where((t) => t.category == category).toList();
    final all = [...bundled, ...filteredCustom];
    return _populateBlockedBy(all);
  }

  @override
  Future<List<TaskTemplate>> searchTemplates(String query) async {
    final bundled = await _templateService.search(query);
    final custom = await getCustomTemplates();
    final lowerQuery = query.toLowerCase();
    final filteredCustom = custom.where((t) {
      return t.title.toLowerCase().contains(lowerQuery) ||
          t.category.toLowerCase().contains(lowerQuery);
    }).toList();
    final all = [...bundled, ...filteredCustom];
    return _populateBlockedBy(all);
  }

  @override
  Future<TaskTemplate?> getTemplateById(String id) async {
    // Try bundled first
    final bundled = await _templateService.getById(id);
    if (bundled != null) {
      final deps = await _db.getDependencies(id);
      return bundled.copyWith(blockedBy: deps);
    }

    // Try custom
    final db = await _db.database;
    final maps = await db.query(
      'custom_templates',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    final template = _mapToTemplate(maps.first);
    final deps = await _db.getDependencies(id);
    return template.copyWith(blockedBy: deps);
  }

  @override
  Future<void> insertCustomTemplate(TaskTemplate template) async {
    final db = await _db.database;
    await db.insert('custom_templates', {
      'id': template.id,
      'category': template.category,
      'title': template.title,
      'steps': json.encode(template.steps.map((s) => s.text).toList()),
      'created_at': DateTime.now().toIso8601String(),
    });
    // Persist dependencies
    for (final depId in template.blockedBy) {
      await _db.addDependency(template.id, depId);
    }
  }

  @override
  Future<void> updateCustomTemplate(TaskTemplate template) async {
    final db = await _db.database;
    await db.update(
      'custom_templates',
      {
        'category': template.category,
        'title': template.title,
        'steps': json.encode(template.steps.map((s) => s.text).toList()),
      },
      where: 'id = ?',
      whereArgs: [template.id],
    );
    // Replace dependencies: remove old, add new
    final existing = await _db.getDependencies(template.id);
    for (final depId in existing) {
      await _db.removeDependency(template.id, depId);
    }
    for (final depId in template.blockedBy) {
      await _db.addDependency(template.id, depId);
    }
  }

  @override
  Future<void> deleteCustomTemplate(String id) async {
    final db = await _db.database;
    await db.delete('custom_templates', where: 'id = ?', whereArgs: [id]);
    // Remove all dependencies for this task
    final existing = await _db.getDependencies(id);
    for (final depId in existing) {
      await _db.removeDependency(id, depId);
    }
  }

  @override
  Future<List<TaskTemplate>> getCustomTemplates() async {
    final db = await _db.database;
    final maps = await db.query('custom_templates', orderBy: 'created_at DESC');
    return maps.map(_mapToTemplate).toList();
  }

  /// Enrich a list of templates with their blockedBy dependency IDs.
  Future<List<TaskTemplate>> _populateBlockedBy(
      List<TaskTemplate> templates) async {
    final result = <TaskTemplate>[];
    for (final t in templates) {
      final deps = await _db.getDependencies(t.id);
      result.add(deps.isEmpty ? t : t.copyWith(blockedBy: deps));
    }
    return result;
  }

  TaskTemplate _mapToTemplate(Map<String, dynamic> map) {
    final stepsJson = json.decode(map['steps'] as String) as List<dynamic>;
    return TaskTemplate(
      id: map['id'] as String,
      category: map['category'] as String,
      title: map['title'] as String,
      steps: stepsJson.map((s) => MicroStep.fromText(s as String)).toList(),
      isCustom: true,
    );
  }
}
