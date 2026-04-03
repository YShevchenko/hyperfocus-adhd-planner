import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/task_template.dart';

/// Loads and searches bundled task templates from assets.
class TemplateService {
  static final TemplateService _instance = TemplateService._();
  factory TemplateService() => _instance;
  TemplateService._();

  List<TaskTemplate>? _cachedTemplates;

  Future<List<TaskTemplate>> loadTemplates() async {
    if (_cachedTemplates != null) return _cachedTemplates!;

    final jsonString =
        await rootBundle.loadString('assets/data/templates.json');
    final data = json.decode(jsonString) as Map<String, dynamic>;
    final templatesList = data['templates'] as List<dynamic>;

    _cachedTemplates = templatesList.asMap().entries.map((entry) {
      final map = entry.value as Map<String, dynamic>;
      final id = 'tmpl_${entry.key}';
      return TaskTemplate.fromJson(map, id);
    }).toList();

    return _cachedTemplates!;
  }

  Future<List<TaskTemplate>> getByCategory(String category) async {
    final templates = await loadTemplates();
    return templates.where((t) => t.category == category).toList();
  }

  Future<List<TaskTemplate>> search(String query) async {
    final templates = await loadTemplates();
    final lowerQuery = query.toLowerCase();
    return templates.where((t) {
      return t.title.toLowerCase().contains(lowerQuery) ||
          t.category.toLowerCase().contains(lowerQuery) ||
          t.steps.any((s) => s.text.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  Future<TaskTemplate?> getById(String id) async {
    final templates = await loadTemplates();
    try {
      return templates.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  void clearCache() {
    _cachedTemplates = null;
  }
}
