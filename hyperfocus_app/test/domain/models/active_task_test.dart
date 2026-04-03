import 'package:flutter_test/flutter_test.dart';
import 'package:hyperfocus_app/domain/models/active_task.dart';
import 'package:hyperfocus_app/domain/models/micro_step.dart';
import 'package:hyperfocus_app/domain/models/task_template.dart';

void main() {
  group('ActiveTask', () {
    late TaskTemplate template;

    setUp(() {
      template = const TaskTemplate(
        id: 'tmpl_1',
        category: 'cleaning',
        title: 'Clean kitchen',
        steps: [
          MicroStep(text: 'Stand up'),
          MicroStep(text: 'Walk to kitchen'),
          MicroStep(text: 'Pick up one item'),
          MicroStep(text: 'Put it away'),
        ],
      );
    });

    test('creates from template', () {
      final task = ActiveTask.fromTemplate(template, 'task_1');
      expect(task.id, 'task_1');
      expect(task.templateId, 'tmpl_1');
      expect(task.title, 'Clean kitchen');
      expect(task.currentStepIndex, 0);
      expect(task.totalSteps, 4);
      expect(task.isCompleted, false);
      expect(task.isLastStep, false);
    });

    test('currentStep returns correct step', () {
      final task = ActiveTask.fromTemplate(template, 'task_1');
      expect(task.currentStep.text, 'Stand up');
    });

    test('advanceStep increments step index', () {
      final task = ActiveTask.fromTemplate(template, 'task_1');
      final next = task.advanceStep();
      expect(next.currentStepIndex, 1);
      expect(next.currentStep.text, 'Walk to kitchen');
      expect(next.stepCompletedTimes.length, 1);
    });

    test('skipStep increments step index', () {
      final task = ActiveTask.fromTemplate(template, 'task_1');
      final skipped = task.skipStep();
      expect(skipped.currentStepIndex, 1);
      expect(skipped.stepCompletedTimes.length, 1);
    });

    test('isLastStep is true at last step', () {
      var task = ActiveTask.fromTemplate(template, 'task_1');
      task = task.advanceStep(); // step 1
      task = task.advanceStep(); // step 2
      task = task.advanceStep(); // step 3 (last)
      expect(task.isLastStep, true);
    });

    test('isCompleted is true after all steps', () {
      var task = ActiveTask.fromTemplate(template, 'task_1');
      task = task.advanceStep();
      task = task.advanceStep();
      task = task.advanceStep();
      task = task.advanceStep();
      expect(task.isCompleted, true);
    });

    test('progress increases with each step', () {
      var task = ActiveTask.fromTemplate(template, 'task_1');
      expect(task.progress, 0.0);
      task = task.advanceStep();
      expect(task.progress, 0.25);
      task = task.advanceStep();
      expect(task.progress, 0.5);
      task = task.advanceStep();
      expect(task.progress, 0.75);
      task = task.advanceStep();
      expect(task.progress, 1.0);
    });

    test('completedSteps tracks progress', () {
      var task = ActiveTask.fromTemplate(template, 'task_1');
      expect(task.completedSteps, 0);
      task = task.advanceStep();
      expect(task.completedSteps, 1);
      task = task.advanceStep();
      expect(task.completedSteps, 2);
    });
  });
}
