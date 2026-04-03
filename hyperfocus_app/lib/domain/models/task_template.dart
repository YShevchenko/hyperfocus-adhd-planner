import 'package:equatable/equatable.dart';

import 'micro_step.dart';

/// A pre-built or custom task breakdown template.
class TaskTemplate extends Equatable {
  final String id;
  final String category;
  final String title;
  final List<MicroStep> steps;
  final bool isCustom;
  /// IDs of templates that must be completed before this one can be started.
  final List<String> blockedBy;

  const TaskTemplate({
    required this.id,
    required this.category,
    required this.title,
    required this.steps,
    this.isCustom = false,
    this.blockedBy = const [],
  });

  TaskTemplate copyWith({
    String? id,
    String? category,
    String? title,
    List<MicroStep>? steps,
    bool? isCustom,
    List<String>? blockedBy,
  }) {
    return TaskTemplate(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      steps: steps ?? this.steps,
      isCustom: isCustom ?? this.isCustom,
      blockedBy: blockedBy ?? this.blockedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'steps': steps.map((s) => s.text).toList(),
      'isCustom': isCustom ? 1 : 0,
      'blockedBy': blockedBy,
    };
  }

  factory TaskTemplate.fromMap(Map<String, dynamic> map) {
    final stepsList = (map['steps'] as List<dynamic>);
    final blockedByRaw = map['blockedBy'];
    final blockedBy = blockedByRaw is List
        ? blockedByRaw.map((e) => e as String).toList()
        : <String>[];
    return TaskTemplate(
      id: map['id'] as String? ?? '',
      category: map['category'] as String,
      title: map['title'] as String,
      steps: stepsList.map((s) {
        if (s is String) return MicroStep.fromText(s);
        return MicroStep.fromMap(s as Map<String, dynamic>);
      }).toList(),
      isCustom: (map['isCustom'] as int?) == 1,
      blockedBy: blockedBy,
    );
  }

  /// From template JSON format (no id, not custom).
  factory TaskTemplate.fromJson(Map<String, dynamic> json, String generatedId) {
    final stepsList = (json['steps'] as List<dynamic>);
    return TaskTemplate(
      id: generatedId,
      category: json['category'] as String,
      title: json['title'] as String,
      steps: stepsList.map((s) {
        if (s is String) return MicroStep.fromText(s);
        return MicroStep.fromMap(s as Map<String, dynamic>);
      }).toList(),
      isCustom: false,
      blockedBy: const [],
    );
  }

  int get stepCount => steps.length;

  @override
  List<Object?> get props => [id, category, title, steps, isCustom, blockedBy];
}
