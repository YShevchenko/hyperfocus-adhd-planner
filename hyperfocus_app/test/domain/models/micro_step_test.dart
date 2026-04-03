import 'package:flutter_test/flutter_test.dart';
import 'package:hyperfocus_app/domain/models/micro_step.dart';

void main() {
  group('MicroStep', () {
    test('creates from text', () {
      final step = MicroStep.fromText('Walk to the kitchen');
      expect(step.text, 'Walk to the kitchen');
      expect(step.durationSeconds, isNull);
    });

    test('creates with duration', () {
      const step = MicroStep(text: 'Wait for water to boil', durationSeconds: 120);
      expect(step.text, 'Wait for water to boil');
      expect(step.durationSeconds, 120);
    });

    test('serializes to map', () {
      const step = MicroStep(text: 'Pick up one dish', durationSeconds: 30);
      final map = step.toMap();
      expect(map['text'], 'Pick up one dish');
      expect(map['durationSeconds'], 30);
    });

    test('deserializes from map', () {
      final step = MicroStep.fromMap({
        'text': 'Wipe the counter',
        'durationSeconds': 60,
      });
      expect(step.text, 'Wipe the counter');
      expect(step.durationSeconds, 60);
    });

    test('serializes without duration when null', () {
      const step = MicroStep(text: 'Stand up');
      final map = step.toMap();
      expect(map['text'], 'Stand up');
      expect(map.containsKey('durationSeconds'), isFalse);
    });

    test('equals another step with same properties', () {
      const step1 = MicroStep(text: 'Step A', durationSeconds: 10);
      const step2 = MicroStep(text: 'Step A', durationSeconds: 10);
      expect(step1, equals(step2));
    });

    test('not equal when text differs', () {
      const step1 = MicroStep(text: 'Step A');
      const step2 = MicroStep(text: 'Step B');
      expect(step1, isNot(equals(step2)));
    });
  });
}
