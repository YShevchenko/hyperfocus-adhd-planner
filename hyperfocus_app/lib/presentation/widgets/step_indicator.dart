import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Subtle progress dots showing current step position.
class StepIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final double dotSize;
  final double spacing;

  const StepIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.dotSize = 8,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    // For many steps, show a condensed version
    if (totalSteps > 10) {
      return _buildCondensed(context);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (index) {
        final isCompleted = index < currentStep;
        final isCurrent = index == currentStep;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isCurrent ? dotSize * 2 : dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.secondary
                  : isCurrent
                      ? AppColors.primary
                      : AppColors.oneThingDimText.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(dotSize / 2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCondensed(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.oneThingDimText.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: totalSteps > 0 ? currentStep / totalSteps : 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
