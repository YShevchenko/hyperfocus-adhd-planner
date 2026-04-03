import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../services/iap_service.dart';
import '../providers/providers.dart';
import '../widgets/chime_selector.dart';

/// Settings screen — timer, chime, sound, premium.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsNotifierProvider);
    final settingsNotifier = ref.read(settingsNotifierProvider.notifier);
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Timer section
          _SectionHeader(title: l10n.timerSettings),
          const SizedBox(height: 8),
          SwitchListTile(
            title: Text(l10n.enableTimer),
            subtitle: Text(l10n.enableTimerDescription),
            value: settings.timerEnabled,
            onChanged: settingsNotifier.setTimerEnabled,
            activeTrackColor: AppColors.secondary,
            contentPadding: EdgeInsets.zero,
          ),
          if (settings.timerEnabled) ...[
            const SizedBox(height: 8),
            Text(
              l10n.defaultStepDuration,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            Slider(
              value: settings.defaultStepDuration.toDouble(),
              min: 30,
              max: 600,
              divisions: 19,
              label: '${settings.defaultStepDuration ~/ 60} min',
              activeColor: AppColors.primary,
              onChanged: (value) {
                settingsNotifier.setDefaultStepDuration(value.toInt());
              },
            ),
            Text(
              '${settings.defaultStepDuration ~/ 60} ${l10n.minutes}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
          const Divider(height: 32),
          // Time-blindness chime
          _SectionHeader(title: l10n.timeBlindness),
          const SizedBox(height: 8),
          if (!isPremium) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lock_rounded,
                      color: AppColors.textSecondary, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.chimePremiumOnly,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ChimeSelector(
              selectedInterval: settings.chimeIntervalMinutes,
              enabled: settings.chimeEnabled,
              onIntervalChanged: settingsNotifier.setChimeIntervalMinutes,
              onEnabledChanged: settingsNotifier.setChimeEnabled,
            ),
          ],
          const Divider(height: 32),
          // Sound
          _SectionHeader(title: l10n.soundSettings),
          const SizedBox(height: 8),
          SwitchListTile(
            title: Text(l10n.enableSound),
            subtitle: Text(l10n.enableSoundDescription),
            value: settings.soundEnabled,
            onChanged: settingsNotifier.setSoundEnabled,
            activeTrackColor: AppColors.secondary,
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(height: 32),
          // Premium
          _SectionHeader(title: l10n.premium),
          const SizedBox(height: 8),
          if (isPremium) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded,
                      color: AppColors.secondary, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    l10n.premiumActive,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.2),
                    AppColors.secondary.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.upgradePremium,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.premiumFeatures,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await IapService().purchasePremium();
                      },
                      child: Text(l10n.buyPremium(AppConstants.premiumPrice)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        await IapService().restorePurchases();
                      },
                      child: Text(l10n.restorePurchases),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const Divider(height: 32),
          // About
          _SectionHeader(title: l10n.about),
          const SizedBox(height: 8),
          ListTile(
            title: Text(l10n.version),
            trailing: Text(
              AppConstants.appVersion,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          ListTile(
            title: Text(l10n.publisher),
            trailing: Text(
              AppConstants.publisher,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          ListTile(
            title: Text(l10n.contact),
            trailing: Text(
              AppConstants.contactEmail,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
