import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hyperfocus_app/domain/models/micro_step.dart';
import 'package:hyperfocus_app/domain/models/task_history.dart';
import 'package:hyperfocus_app/domain/models/task_template.dart';
import 'package:hyperfocus_app/domain/repositories/history_repository.dart';
import 'package:hyperfocus_app/presentation/providers/task_notifier.dart';
import 'package:hyperfocus_app/services/ad_service.dart';

/// Fake history repository for testing.
class FakeHistoryRepository implements HistoryRepository {
  final List<TaskHistory> _history = [];

  @override
  Future<List<TaskHistory>> getAllHistory() async => _history;

  @override
  Future<List<TaskHistory>> getRecentHistory({int limit = 20}) async =>
      _history.take(limit).toList();

  @override
  Future<void> insertHistory(TaskHistory history) async {
    _history.add(history);
  }

  @override
  Future<void> deleteHistory(String id) async {
    _history.removeWhere((h) => h.id == id);
  }

  @override
  Future<void> clearAllHistory() async {
    _history.clear();
  }

  @override
  Future<int> getCompletedTaskCount() async => _history.length;

  @override
  Future<int> getTotalStepsCompleted() async {
    int total = 0;
    for (final h in _history) {
      total += h.completedSteps;
    }
    return total;
  }
}

void main() {
  group('TaskNotifier', () {
    late TaskNotifier notifier;
    late FakeHistoryRepository historyRepo;

    const template = TaskTemplate(
      id: 'tmpl_test',
      category: 'cleaning',
      title: 'Test Task',
      steps: [
        MicroStep(text: 'Step 1'),
        MicroStep(text: 'Step 2'),
        MicroStep(text: 'Step 3'),
      ],
    );

    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      historyRepo = FakeHistoryRepository();
      final adService = AdService();
      adService.isPremium = true; // Skip ad logic in tests
      notifier = TaskNotifier(historyRepo, adService);
    });

    test('initial state is null', () {
      expect(notifier.state, isNull);
    });

    test('startTask sets active task', () {
      notifier.startTask(template);
      expect(notifier.state, isNotNull);
      expect(notifier.state!.title, 'Test Task');
      expect(notifier.state!.currentStepIndex, 0);
    });

    test('completeStep advances to next step', () async {
      notifier.startTask(template);
      await notifier.completeStep();
      expect(notifier.state!.currentStepIndex, 1);
    });

    test('skipStep advances to next step', () async {
      notifier.startTask(template);
      await notifier.skipStep();
      expect(notifier.state!.currentStepIndex, 1);
    });

    test('completing all steps records history', () async {
      notifier.startTask(template);
      await notifier.completeStep();
      await notifier.completeStep();
      await notifier.completeStep();

      // Task is completed, history should have one entry
      final count = await historyRepo.getCompletedTaskCount();
      expect(count, 1);
    });

    test('completing all steps marks task as completed', () async {
      notifier.startTask(template);
      await notifier.completeStep();
      await notifier.completeStep();
      await notifier.completeStep();

      expect(notifier.state!.isCompleted, true);
    });

    test('abandonTask clears state', () {
      notifier.startTask(template);
      notifier.abandonTask();
      expect(notifier.state, isNull);
    });

    test('clearTask clears state', () {
      notifier.startTask(template);
      notifier.clearTask();
      expect(notifier.state, isNull);
    });

    test('skipping all steps records history', () async {
      notifier.startTask(template);
      await notifier.skipStep();
      await notifier.skipStep();
      await notifier.skipStep();

      final count = await historyRepo.getCompletedTaskCount();
      expect(count, 1);
    });
  });
}
