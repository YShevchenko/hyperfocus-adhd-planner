import 'package:equatable/equatable.dart';

/// A record of a completed task.
class TaskHistory extends Equatable {
  final String id;
  final String templateId;
  final String title;
  final String category;
  final int totalSteps;
  final int completedSteps;
  final DateTime startedAt;
  final DateTime completedAt;
  final int durationSeconds;

  const TaskHistory({
    required this.id,
    required this.templateId,
    required this.title,
    required this.category,
    required this.totalSteps,
    required this.completedSteps,
    required this.startedAt,
    required this.completedAt,
    required this.durationSeconds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'template_id': templateId,
      'title': title,
      'category': category,
      'total_steps': totalSteps,
      'completed_steps': completedSteps,
      'started_at': startedAt.toIso8601String(),
      'completed_at': completedAt.toIso8601String(),
      'duration_seconds': durationSeconds,
    };
  }

  factory TaskHistory.fromMap(Map<String, dynamic> map) {
    return TaskHistory(
      id: map['id'] as String,
      templateId: map['template_id'] as String,
      title: map['title'] as String,
      category: map['category'] as String,
      totalSteps: map['total_steps'] as int,
      completedSteps: map['completed_steps'] as int,
      startedAt: DateTime.parse(map['started_at'] as String),
      completedAt: DateTime.parse(map['completed_at'] as String),
      durationSeconds: map['duration_seconds'] as int,
    );
  }

  String get formattedDuration {
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    if (minutes == 0) return '${seconds}s';
    return '${minutes}m ${seconds}s';
  }

  @override
  List<Object?> get props => [
        id,
        templateId,
        title,
        category,
        totalSteps,
        completedSteps,
        startedAt,
        completedAt,
        durationSeconds,
      ];
}
