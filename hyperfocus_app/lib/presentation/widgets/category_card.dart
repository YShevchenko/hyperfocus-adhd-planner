import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final int templateCount;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.templateCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _categoryColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _categoryIcon,
              color: _categoryColor,
              size: 32,
            ),
            const Spacer(),
            Text(
              _categoryTitle(l10n),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              '$templateCount ${l10n.tasks}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryTitle(AppLocalizations l10n) {
    switch (category) {
      case 'cleaning':
        return l10n.categoryCleaning;
      case 'self_care':
        return l10n.categorySelfCare;
      case 'admin':
        return l10n.categoryAdmin;
      case 'work':
        return l10n.categoryWork;
      case 'cooking':
        return l10n.categoryCooking;
      case 'social':
        return l10n.categorySocial;
      default:
        return category;
    }
  }

  IconData get _categoryIcon {
    switch (category) {
      case 'cleaning':
        return Icons.cleaning_services_rounded;
      case 'self_care':
        return Icons.spa_rounded;
      case 'admin':
        return Icons.folder_rounded;
      case 'work':
        return Icons.work_rounded;
      case 'cooking':
        return Icons.restaurant_rounded;
      case 'social':
        return Icons.people_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  Color get _categoryColor {
    switch (category) {
      case 'cleaning':
        return AppColors.cleaningColor;
      case 'self_care':
        return AppColors.selfCareColor;
      case 'admin':
        return AppColors.adminColor;
      case 'work':
        return AppColors.workColor;
      case 'cooking':
        return AppColors.cookingColor;
      case 'social':
        return AppColors.socialColor;
      default:
        return AppColors.primary;
    }
  }
}
