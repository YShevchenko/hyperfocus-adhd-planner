import 'package:flutter_test/flutter_test.dart';
import 'package:hyperfocus_app/domain/models/micro_step.dart';
import 'package:hyperfocus_app/domain/models/task_template.dart';

void main() {
  group('TaskTemplate', () {
    test('creates with required fields', () {
      const template = TaskTemplate(
        id: 'test_1',
        category: 'cleaning',
        title: 'Clean the kitchen',
        steps: [
          MicroStep(text: 'Stand up'),
          MicroStep(text: 'Walk to kitchen'),
          MicroStep(text: 'Pick up one item'),
        ],
      );
      expect(template.id, 'test_1');
      expect(template.category, 'cleaning');
      expect(template.title, 'Clean the kitchen');
      expect(template.stepCount, 3);
      expect(template.isCustom, false);
    });

    test('fromJson creates template from JSON format', () {
      final json = {
        'category': 'self_care',
        'title': 'Brush teeth',
        'steps': ['Get toothbrush', 'Apply toothpaste', 'Brush'],
      };
      final template = TaskTemplate.fromJson(json, 'tmpl_0');
      expect(template.id, 'tmpl_0');
      expect(template.category, 'self_care');
      expect(template.title, 'Brush teeth');
      expect(template.stepCount, 3);
      expect(template.steps[0].text, 'Get toothbrush');
      expect(template.isCustom, false);
    });

    test('fromMap creates template with isCustom flag', () {
      final map = {
        'id': 'custom_1',
        'category': 'work',
        'title': 'Write report',
        'steps': ['Open editor', 'Write intro'],
        'isCustom': 1,
      };
      final template = TaskTemplate.fromMap(map);
      expect(template.isCustom, true);
      expect(template.stepCount, 2);
    });

    test('toMap serializes correctly', () {
      const template = TaskTemplate(
        id: 'test_2',
        category: 'cooking',
        title: 'Make coffee',
        steps: [
          MicroStep(text: 'Boil water'),
          MicroStep(text: 'Pour'),
        ],
        isCustom: true,
      );
      final map = template.toMap();
      expect(map['id'], 'test_2');
      expect(map['category'], 'cooking');
      expect(map['title'], 'Make coffee');
      expect(map['isCustom'], 1);
      expect(map['steps'], ['Boil water', 'Pour']);
    });

    test('copyWith creates modified copy', () {
      const template = TaskTemplate(
        id: 't1',
        category: 'admin',
        title: 'Pay bill',
        steps: [MicroStep(text: 'Open app')],
      );
      final modified = template.copyWith(title: 'Pay electric bill');
      expect(modified.title, 'Pay electric bill');
      expect(modified.id, 't1');
      expect(modified.category, 'admin');
    });

    test('equality works', () {
      const t1 = TaskTemplate(
        id: 'a',
        category: 'cleaning',
        title: 'Test',
        steps: [MicroStep(text: 'Step')],
      );
      const t2 = TaskTemplate(
        id: 'a',
        category: 'cleaning',
        title: 'Test',
        steps: [MicroStep(text: 'Step')],
      );
      expect(t1, equals(t2));
    });
  });
}
