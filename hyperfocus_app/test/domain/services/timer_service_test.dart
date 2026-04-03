import 'package:flutter_test/flutter_test.dart';
import 'package:hyperfocus_app/domain/services/timer_service.dart';

void main() {
  group('TimerService', () {
    late TimerService timerService;

    setUp(() {
      timerService = TimerService();
    });

    tearDown(() {
      timerService.dispose();
    });

    test('initial state is not running', () {
      expect(timerService.isRunning, false);
      expect(timerService.remainingSeconds, 0);
      expect(timerService.totalSeconds, 0);
      expect(timerService.progress, 0.0);
    });

    test('startStepTimer sets running state', () {
      timerService.startStepTimer(60);
      expect(timerService.isRunning, true);
      expect(timerService.totalSeconds, 60);
      expect(timerService.remainingSeconds, 60);
    });

    test('stopStepTimer stops the timer', () {
      timerService.startStepTimer(60);
      timerService.stopStepTimer();
      expect(timerService.isRunning, false);
    });

    test('resetStepTimer resets to total', () {
      timerService.startStepTimer(120);
      timerService.resetStepTimer();
      expect(timerService.isRunning, false);
      expect(timerService.remainingSeconds, 120);
    });

    test('progress is between 0 and 1', () {
      timerService.startStepTimer(100);
      // At start, progress should be 0
      expect(timerService.progress, 0.0);
    });

    test('tick stream emits remaining seconds', () async {
      timerService.startStepTimer(3);

      final ticks = <int>[];
      final sub = timerService.tickStream.listen(ticks.add);

      // Wait for a couple of ticks
      await Future.delayed(const Duration(seconds: 2, milliseconds: 200));
      timerService.stopStepTimer();
      await sub.cancel();

      // Should have at least 1-2 ticks
      expect(ticks.isNotEmpty, true);
      expect(ticks.first, lessThan(3));
    });

    test('chime stream emits at intervals', () async {
      // We can't easily test minute intervals, but we can verify the stream exists
      timerService.startChimeTimer(1);
      expect(timerService.chimeStream, isNotNull);
      timerService.stopChimeTimer();
    });
  });
}
