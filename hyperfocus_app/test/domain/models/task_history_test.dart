import 'package:flutter_test/flutter_test.dart';
import 'package:hyperfocus_app/domain/models/task_history.dart';

void main() {
  group('TaskHistory', () {
    test('creates with all required fields', () {
      final history = TaskHistory(
        id: 'h1',
        templateId: 'tmpl_1',
        title: 'Clean kitchen',
        category: 'cleaning',
        totalSteps: 5,
        completedSteps: 5,
        startedAt: DateTime(2026, 4, 1, 10, 0),
        completedAt: DateTime(2026, 4, 1, 10, 15),
        durationSeconds: 900,
      );
      expect(history.id, 'h1');
      expect(history.totalSteps, 5);
      expect(history.durationSeconds, 900);
    });

    test('formattedDuration shows minutes and seconds', () {
      final history = TaskHistory(
        id: 'h1',
        templateId: 'tmpl_1',
        title: 'Test',
        category: 'work',
        totalSteps: 3,
        completedSteps: 3,
        startedAt: DateTime(2026, 4, 1),
        completedAt: DateTime(2026, 4, 1),
        durationSeconds: 125,
      );
      expect(history.formattedDuration, '2m 5s');
    });

    test('formattedDuration shows only seconds when under a minute', () {
      final history = TaskHistory(
        id: 'h2',
        templateId: 'tmpl_2',
        title: 'Quick task',
        category: 'admin',
        totalSteps: 2,
        completedSteps: 2,
        startedAt: DateTime(2026, 4, 1),
        completedAt: DateTime(2026, 4, 1),
        durationSeconds: 45,
      );
      expect(history.formattedDuration, '45s');
    });

    test('serializes to map', () {
      final started = DateTime(2026, 4, 1, 10, 0);
      final completed = DateTime(2026, 4, 1, 10, 5);
      final history = TaskHistory(
        id: 'h3',
        templateId: 'tmpl_3',
        title: 'Shower',
        category: 'self_care',
        totalSteps: 8,
        completedSteps: 8,
        startedAt: started,
        completedAt: completed,
        durationSeconds: 300,
      );

      final map = history.toMap();
      expect(map['id'], 'h3');
      expect(map['template_id'], 'tmpl_3');
      expect(map['title'], 'Shower');
      expect(map['category'], 'self_care');
      expect(map['total_steps'], 8);
      expect(map['completed_steps'], 8);
      expect(map['started_at'], started.toIso8601String());
      expect(map['completed_at'], completed.toIso8601String());
      expect(map['duration_seconds'], 300);
    });

    test('deserializes from map', () {
      final map = {
        'id': 'h4',
        'template_id': 'tmpl_4',
        'title': 'Dishes',
        'category': 'cleaning',
        'total_steps': 6,
        'completed_steps': 5,
        'started_at': '2026-04-01T09:00:00.000',
        'completed_at': '2026-04-01T09:10:00.000',
        'duration_seconds': 600,
      };

      final history = TaskHistory.fromMap(map);
      expect(history.id, 'h4');
      expect(history.templateId, 'tmpl_4');
      expect(history.totalSteps, 6);
      expect(history.completedSteps, 5);
      expect(history.durationSeconds, 600);
    });

    test('equality works', () {
      final h1 = TaskHistory(
        id: 'x',
        templateId: 't',
        title: 'T',
        category: 'c',
        totalSteps: 1,
        completedSteps: 1,
        startedAt: DateTime(2026),
        completedAt: DateTime(2026),
        durationSeconds: 10,
      );
      final h2 = TaskHistory(
        id: 'x',
        templateId: 't',
        title: 'T',
        category: 'c',
        totalSteps: 1,
        completedSteps: 1,
        startedAt: DateTime(2026),
        completedAt: DateTime(2026),
        durationSeconds: 10,
      );
      expect(h1, equals(h2));
    });
  });
}
