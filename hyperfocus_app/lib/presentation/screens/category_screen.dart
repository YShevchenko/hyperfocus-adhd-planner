import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/models/task_template.dart';
import '../../l10n/app_localizations.dart';
import '../providers/providers.dart';
import 'breakdown_preview_screen.dart';

/// Browsable list of templates within a category.
class CategoryScreen extends ConsumerWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final templates = ref.watch(templatesByCategoryProvider(category));
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle(l10n)),
      ),
      body: templates.when(
        data: (templateList) {
          if (templateList.isEmpty) {
            return Center(
              child: Text(
                l10n.noTemplatesInCategory,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: templateList.length,
            itemBuilder: (context, index) {
              final template = templateList[index];
              return _TemplateListItem(
                template: template,
                isPremium: isPremium,
                l10n: l10n,
                onShowPremiumDialog: () => _showPremiumDialog(context, l10n),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, _) => Center(
          child: Text(l10n.errorLoading,
              style: const TextStyle(color: AppColors.error)),
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

  void _showPremiumDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.premiumRequired),
        content: Text(l10n.premiumDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.maybeLater),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Navigate to settings/premium purchase
            },
            child: Text(l10n.upgradePremium),
          ),
        ],
      ),
    );
  }
}

// ── Per-template list item with dependency-block awareness ─────────────────────

class _TemplateListItem extends ConsumerWidget {
  final TaskTemplate template;
  final bool isPremium;
  final AppLocalizations l10n;
  final VoidCallback onShowPremiumDialog;

  const _TemplateListItem({
    required this.template,
    required this.isPremium,
    required this.l10n,
    required this.onShowPremiumDialog,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Free users can only use custom templates
    final isPremiumLocked = !isPremium && !template.isCustom;
    final isDepBlocked = ref.watch(templateIsBlockedProvider(template));

    Widget trailing;
    if (isPremiumLocked) {
      trailing = const Icon(Icons.lock_rounded,
          size: 20, color: AppColors.textSecondary);
    } else if (isDepBlocked) {
      trailing = const Icon(Icons.lock_clock_rounded,
          size: 20, color: AppColors.textSecondary);
    } else {
      trailing = const Icon(Icons.arrow_forward_ios_rounded,
          size: 16, color: AppColors.textSecondary);
    }

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      title: Text(
        template.title,
        style: isDepBlocked
            ? const TextStyle(color: AppColors.textSecondary)
            : null,
      ),
      subtitle: Text(
        '${template.stepCount} ${l10n.steps}',
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: trailing,
      onTap: () {
        if (isPremiumLocked) {
          onShowPremiumDialog();
          return;
        }
        if (isDepBlocked) {
          _showBlockedSnackbar(context, ref);
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BreakdownPreviewScreen(template: template),
          ),
        );
      },
    );
  }

  void _showBlockedSnackbar(BuildContext context, WidgetRef ref) {
    final unmetAsync = ref.read(unmetDependencyNamesProvider(template));
    unmetAsync.whenOrNull(
      data: (names) {
        final msg = names.isEmpty
            ? 'Complete blocking tasks first.'
            : 'Complete "${names.first}" first.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      },
    );
    // Fallback if data isn't loaded yet
    if (!unmetAsync.hasValue) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Complete blocking tasks first.')),
      );
    }
  }
}
