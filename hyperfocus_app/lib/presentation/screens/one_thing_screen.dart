import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/services/timer_service.dart';
import '../../l10n/app_localizations.dart';
import '../../services/audio_service.dart';
import '../../services/chime_foreground_service.dart';
import '../providers/providers.dart';
import '../widgets/pie_timer.dart';
import '../widgets/step_indicator.dart';
import 'completion_screen.dart';

/// THE CORE: black screen, single instruction, pie timer, Done button.
class OneThingScreen extends ConsumerStatefulWidget {
  const OneThingScreen({super.key});

  @override
  ConsumerState<OneThingScreen> createState() => _OneThingScreenState();
}

class _OneThingScreenState extends ConsumerState<OneThingScreen> {
  TimerService? _timerService;
  StreamSubscription<int>? _tickSub;
  StreamSubscription<void>? _chimeSub;
  int _remainingSeconds = 0;
  double _timerProgress = 0.0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    // Immersive mode — hide system bars
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupTimer();
      _setupChime();
    });
  }

  void _setupTimer() {
    final settings = ref.read(settingsNotifierProvider);
    if (!settings.timerEnabled) return;

    _timerService = ref.read(timerServiceProvider);
    _timerService!.startStepTimer(settings.defaultStepDuration);
    _remainingSeconds = settings.defaultStepDuration;

    _tickSub = _timerService!.tickStream.listen((remaining) {
      if (mounted) {
        setState(() {
          _remainingSeconds = remaining;
          _timerProgress = _timerService!.progress;
        });
      }
    });
  }

  void _setupChime() {
    final settings = ref.read(settingsNotifierProvider);
    if (!settings.chimeEnabled) return;

    // Start foreground service so chimes survive screen lock / backgrounding.
    ChimeForegroundService.start(settings.chimeIntervalMinutes);

    // Keep the in-process timer as a fallback for when the app is foregrounded.
    _timerService ??= ref.read(timerServiceProvider);
    _timerService!.startChimeTimer(settings.chimeIntervalMinutes);

    _chimeSub = _timerService!.chimeStream.listen((_) {
      if (settings.soundEnabled) {
        AudioService().playChime();
      }
    });
  }

  @override
  void dispose() {
    _tickSub?.cancel();
    _chimeSub?.cancel();
    _timerService?.stopStepTimer();
    _timerService?.stopChimeTimer();
    ChimeForegroundService.stop();
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _onDone() {
    final task = ref.read(taskNotifierProvider);
    if (task == null) return;

    // Satisfying haptic on step advance (dopamine hit)
    HapticFeedback.heavyImpact();

    // Play step-complete sound
    final settings = ref.read(settingsNotifierProvider);
    if (settings.soundEnabled) {
      AudioService().playStepComplete();
    }

    // Reset step timer for next step
    _timerService?.stopStepTimer();

    ref.read(taskNotifierProvider.notifier).completeStep();

    final updatedTask = ref.read(taskNotifierProvider);
    if (updatedTask != null && updatedTask.isCompleted) {
      _navigateToCompletion();
    } else {
      // Start timer for next step
      final settings = ref.read(settingsNotifierProvider);
      if (settings.timerEnabled) {
        _timerService?.startStepTimer(settings.defaultStepDuration);
        _remainingSeconds = settings.defaultStepDuration;
        _timerProgress = 0.0;
      }
      setState(() {});
    }
  }

  void _onSkip() {
    // Light haptic for skip — non-punitive but still tactile
    HapticFeedback.lightImpact();

    _timerService?.stopStepTimer();

    ref.read(taskNotifierProvider.notifier).skipStep();

    final updatedTask = ref.read(taskNotifierProvider);
    if (updatedTask != null && updatedTask.isCompleted) {
      _navigateToCompletion();
    } else {
      final settings = ref.read(settingsNotifierProvider);
      if (settings.timerEnabled) {
        _timerService?.startStepTimer(settings.defaultStepDuration);
        _remainingSeconds = settings.defaultStepDuration;
        _timerProgress = 0.0;
      }
      setState(() {});
    }
  }

  void _onPauseResume() {
    if (_timerService == null) return;
    setState(() {
      if (_isPaused) {
        _timerService!.resumeStepTimer();
        _isPaused = false;
      } else {
        _timerService!.pauseStepTimer();
        _isPaused = true;
      }
    });
  }

  void _navigateToCompletion() {
    _timerService?.stopChimeTimer();
    ChimeForegroundService.stop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const CompletionScreen(),
      ),
    );
  }

  void _onAbandon() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(l10n.abandonTask),
        content: Text(l10n.abandonTaskConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.keepGoing),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(taskNotifierProvider.notifier).abandonTask();
              _timerService?.stopStepTimer();
              _timerService?.stopChimeTimer();
              ChimeForegroundService.stop();
              Navigator.pop(context);
            },
            child: Text(
              l10n.yesAbandon,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final task = ref.watch(taskNotifierProvider);
    final settings = ref.watch(settingsNotifierProvider);
    final l10n = AppLocalizations.of(context)!;

    if (task == null || task.isCompleted) {
      return const Scaffold(
        backgroundColor: AppColors.oneThingBackground,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.oneThingBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar — step counter and close button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Step counter (dim)
                  Text(
                    l10n.stepOf(
                        task.currentStepIndex + 1, task.totalSteps),
                    style: const TextStyle(
                      color: AppColors.oneThingDimText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Close / abandon
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.oneThingDimText, size: 24),
                    onPressed: _onAbandon,
                  ),
                ],
              ),
            ),
            // Step indicator dots
            StepIndicator(
              totalSteps: task.totalSteps,
              currentStep: task.currentStepIndex,
            ),
            // Main instruction — centered
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Pie timer (optional)
                    if (settings.timerEnabled) ...[
                      PieTimer(
                        progress: _timerProgress,
                        remainingSeconds: _remainingSeconds,
                        size: 100,
                        color: AppColors.primary,
                        backgroundColor:
                            AppColors.oneThingDimText.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 40),
                    ],
                    // THE instruction
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        task.currentStep.text,
                        key: ValueKey(task.currentStepIndex),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.oneThingText,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  // Done button (large, primary)
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _onDone,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        l10n.done,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Pause/Resume and Skip row — non-punitive, equally subtle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (settings.timerEnabled) ...[
                        TextButton(
                          onPressed: _onPauseResume,
                          child: Text(
                            _isPaused ? l10n.resumeTimer : l10n.pauseTimer,
                            style: const TextStyle(
                              color: AppColors.oneThingDimText,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '·',
                          style: const TextStyle(
                            color: AppColors.oneThingDimText,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      TextButton(
                        onPressed: _onSkip,
                        child: Text(
                          l10n.skipThisStep,
                          style: const TextStyle(
                            color: AppColors.oneThingDimText,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
