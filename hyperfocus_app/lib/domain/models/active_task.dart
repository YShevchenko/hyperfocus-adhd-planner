import 'package:equatable/equatable.dart';

import 'micro_step.dart';
import 'task_template.dart';

/// Represents a task currently being worked on.
class ActiveTask extends Equatable {
  final String id;
  final String templateId;
  final String title;
  final String category;
  final List<MicroStep> steps;
  final int currentStepIndex;
  final DateTime startedAt;
  final List<DateTime> stepCompletedTimes;

  const ActiveTask({
    required this.id,
    required this.templateId,
    required this.title,
    required this.category,
    required this.steps,
    required this.currentStepIndex,
    required this.startedAt,
    required this.stepCompletedTimes,
  });

  factory ActiveTask.fromTemplate(TaskTemplate template, String taskId) {
    return ActiveTask(
      id: taskId,
      templateId: template.id,
      title: template.title,
      category: template.category,
      steps: template.steps,
      currentStepIndex: 0,
      startedAt: DateTime.now(),
      stepCompletedTimes: const [],
    );
  }

  MicroStep get currentStep => steps[currentStepIndex];
  bool get isLastStep => currentStepIndex >= steps.length - 1;
  bool get isCompleted => currentStepIndex >= steps.length;
  int get totalSteps => steps.length;
  int get completedSteps => currentStepIndex;

  double get progress {
    if (steps.isEmpty) return 0.0;
    return currentStepIndex / steps.length;
  }

  ActiveTask advanceStep() {
    return ActiveTask(
      id: id,
      templateId: templateId,
      title: title,
      category: category,
      steps: steps,
      currentStepIndex: currentStepIndex + 1,
      startedAt: startedAt,
      stepCompletedTimes: [
        ...stepCompletedTimes,
        DateTime.now(),
      ],
    );
  }

  ActiveTask skipStep() {
    return ActiveTask(
      id: id,
      templateId: templateId,
      title: title,
      category: category,
      steps: steps,
      currentStepIndex: currentStepIndex + 1,
      startedAt: startedAt,
      stepCompletedTimes: [
        ...stepCompletedTimes,
        DateTime.now(),
      ],
    );
  }

  Duration get elapsed => DateTime.now().difference(startedAt);

  @override
  List<Object?> get props => [
        id,
        templateId,
        title,
        category,
        steps,
        currentStepIndex,
        startedAt,
        stepCompletedTimes,
      ];
}
