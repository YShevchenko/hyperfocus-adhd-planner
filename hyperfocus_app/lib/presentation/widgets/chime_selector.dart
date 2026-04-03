import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

/// Widget for selecting time-blindness chime interval.
class ChimeSelector extends StatelessWidget {
  final int selectedInterval;
  final bool enabled;
  final ValueChanged<int> onIntervalChanged;
  final ValueChanged<bool> onEnabledChanged;

  const ChimeSelector({
    super.key,
    required this.selectedInterval,
    required this.enabled,
    required this.onIntervalChanged,
    required this.onEnabledChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.timeBlindnessChime,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Switch(
              value: enabled,
              onChanged: onEnabledChanged,
              activeTrackColor: AppColors.secondary,
            ),
          ],
        ),
        if (enabled) ...[
          const SizedBox(height: 12),
          Text(
            l10n.chimeEvery,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: AppConstants.chimeIntervals.map((interval) {
              final isSelected = interval == selectedInterval;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(
                    l10n.minutesShort(interval),
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.textOnPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.secondary,
                  backgroundColor: AppColors.surfaceLight,
                  onSelected: (_) => onIntervalChanged(interval),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
