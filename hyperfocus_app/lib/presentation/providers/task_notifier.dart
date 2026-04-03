import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/active_task.dart';
import '../../domain/models/task_history.dart';
import '../../domain/models/task_template.dart';
import '../../domain/repositories/history_repository.dart';
import '../../services/ad_service.dart';

/// Manages the active task state — starting, advancing, skipping, completing.
class TaskNotifier extends StateNotifier<ActiveTask?> {
  final HistoryRepository _historyRepository;
  final AdService _adService;
  static const _uuid = Uuid();

  TaskNotifier(this._historyRepository, this._adService) : super(null);

  /// Start a new task from a template.
  void startTask(TaskTemplate template) {
    state = ActiveTask.fromTemplate(template, _uuid.v4());
  }

  /// Complete the current step and advance to the next.
  Future<void> completeStep() async {
    if (state == null) return;

    final advanced = state!.advanceStep();

    if (advanced.currentStepIndex >= advanced.totalSteps) {
      // Task completed
      await _recordCompletion(advanced);
      await _adService.trackTaskCompletion();
      state = advanced;
    } else {
      state = advanced;
    }
  }

  /// Skip the current step.
  Future<void> skipStep() async {
    if (state == null) return;

    final skipped = state!.skipStep();

    if (skipped.currentStepIndex >= skipped.totalSteps) {
      await _recordCompletion(skipped);
      await _adService.trackTaskCompletion();
      state = skipped;
    } else {
      state = skipped;
    }
  }

  /// Abandon the current task.
  void abandonTask() {
    state = null;
  }

  /// Clear task after completion screen.
  void clearTask() {
    state = null;
  }

  Future<void> _recordCompletion(ActiveTask task) async {
    final now = DateTime.now();
    final duration = now.difference(task.startedAt);

    final history = TaskHistory(
      id: _uuid.v4(),
      templateId: task.templateId,
      title: task.title,
      category: task.category,
      totalSteps: task.totalSteps,
      completedSteps: task.currentStepIndex,
      startedAt: task.startedAt,
      completedAt: now,
      durationSeconds: duration.inSeconds,
    );

    await _historyRepository.insertHistory(history);
  }
}
