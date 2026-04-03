import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../services/audio_service.dart';
import '../providers/providers.dart';
import '../widgets/celebration_animation.dart';

/// Celebration screen shown after completing all steps.
class CompletionScreen extends ConsumerStatefulWidget {
  const CompletionScreen({super.key});

  @override
  ConsumerState<CompletionScreen> createState() => _CompletionScreenState();
}

class _CompletionScreenState extends ConsumerState<CompletionScreen> {
  @override
  void initState() {
    super.initState();
    // Play celebration sound
    final settings = ref.read(settingsNotifierProvider);
    if (settings.soundEnabled) {
      AudioService().playCelebration();
    }
    // Refresh history
    ref.read(historyNotifierProvider.notifier).loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final task = ref.watch(taskNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Celebration animation
              const SizedBox(
                height: 200,
                child: CelebrationAnimation(),
              ),
              const SizedBox(height: 32),
              // Congratulations message
              Text(
                l10n.youDidIt,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.secondary,
                    ),
              ),
              const SizedBox(height: 12),
              if (task != null) ...[
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.completedStepsCount(task.totalSteps),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.timeTaken(task.elapsed.inMinutes),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
              const SizedBox(height: 16),
              // Encouraging message
              Text(
                _encouragingMessage(l10n),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Back to home
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(taskNotifierProvider.notifier).clearTask();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                  ),
                  child: Text(l10n.backToHome),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _encouragingMessage(AppLocalizations l10n) {
    final messages = [
      l10n.encouragement1,
      l10n.encouragement2,
      l10n.encouragement3,
      l10n.encouragement4,
      l10n.encouragement5,
    ];
    final index = DateTime.now().millisecondsSinceEpoch % messages.length;
    return messages[index];
  }
}
