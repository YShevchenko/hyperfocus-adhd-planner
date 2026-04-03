import 'dart:async';

import 'package:flutter/foundation.dart';

/// Service for pie timer countdown and time-blindness chimes.
class TimerService {
  Timer? _stepTimer;
  Timer? _chimeTimer;
  int _remainingSeconds = 0;
  int _totalSeconds = 0;
  int _chimeIntervalMinutes = 0;
  bool _isRunning = false;

  final _tickController = StreamController<int>.broadcast();
  final _completeController = StreamController<void>.broadcast();
  final _chimeController = StreamController<void>.broadcast();

  Stream<int> get tickStream => _tickController.stream;
  Stream<void> get completeStream => _completeController.stream;
  Stream<void> get chimeStream => _chimeController.stream;

  int get remainingSeconds => _remainingSeconds;
  int get totalSeconds => _totalSeconds;
  bool get isRunning => _isRunning;

  double get progress {
    if (_totalSeconds == 0) return 0.0;
    return 1.0 - (_remainingSeconds / _totalSeconds);
  }

  void startStepTimer(int durationSeconds) {
    stopStepTimer();
    _totalSeconds = durationSeconds;
    _remainingSeconds = durationSeconds;
    _isRunning = true;

    _stepTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        _tickController.add(_remainingSeconds);
      }
      if (_remainingSeconds <= 0) {
        _isRunning = false;
        _completeController.add(null);
        stopStepTimer();
      }
    });
  }

  void stopStepTimer() {
    _stepTimer?.cancel();
    _stepTimer = null;
    _isRunning = false;
  }

  void pauseStepTimer() {
    if (!_isRunning) return;
    _stepTimer?.cancel();
    _stepTimer = null;
    _isRunning = false;
  }

  void resumeStepTimer() {
    if (_isRunning || _remainingSeconds <= 0) return;
    _isRunning = true;

    _stepTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        _tickController.add(_remainingSeconds);
      }
      if (_remainingSeconds <= 0) {
        _isRunning = false;
        _completeController.add(null);
        stopStepTimer();
      }
    });
  }

  void resetStepTimer() {
    stopStepTimer();
    _remainingSeconds = _totalSeconds;
    _tickController.add(_remainingSeconds);
  }

  void startChimeTimer(int intervalMinutes) {
    stopChimeTimer();
    if (intervalMinutes <= 0) return;
    _chimeIntervalMinutes = intervalMinutes;

    _chimeTimer = Timer.periodic(
      Duration(minutes: intervalMinutes),
      (_) {
        debugPrint('Time-blindness chime at $_chimeIntervalMinutes min');
        _chimeController.add(null);
      },
    );
  }

  void stopChimeTimer() {
    _chimeTimer?.cancel();
    _chimeTimer = null;
    _chimeIntervalMinutes = 0;
  }

  void dispose() {
    stopStepTimer();
    stopChimeTimer();
    _tickController.close();
    _completeController.close();
    _chimeController.close();
  }
}
