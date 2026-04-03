import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../providers/providers.dart';
import 'breakdown_preview_screen.dart';
import 'category_screen.dart';
import 'custom_task_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

/// Entry screen: "What's overwhelming you?"
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar
            SliverAppBar(
              floating: true,
              backgroundColor: AppColors.background,
              title: Text(l10n.appTitle),
              actions: [
                IconButton(
                  icon: const Icon(Icons.history_rounded),
                  onPressed: () => _openHistory(context),
                  tooltip: l10n.history,
                ),
                IconButton(
                  icon: const Icon(Icons.settings_rounded),
                  onPressed: () => _openSettings(context),
                  tooltip: l10n.settings,
                ),
              ],
            ),
            // Hero text
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.whatsOverwhelming,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.homeSubtitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            // Search field
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _isSearching = value.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: l10n.searchHint,
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: AppColors.textSecondary),
                    suffixIcon: _isSearching
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _isSearching = false);
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),
            // Search results or categories
            if (_isSearching)
              _buildSearchResults(context, l10n)
            else ...[
              // Categories grid
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                  child: Text(
                    l10n.pickCategory,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              _buildCategoryGrid(context, l10n, isPremium),
              // Custom task button
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: OutlinedButton.icon(
                    onPressed: () => _openCustomTask(context),
                    icon: const Icon(Icons.add_rounded),
                    label: Text(l10n.createCustomTask),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, AppLocalizations l10n) {
    final query = _searchController.text;
    final searchResults = ref.watch(templateSearchProvider(query));

    return searchResults.when(
      data: (templates) {
        if (templates.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                children: [
                  const Icon(Icons.search_off_rounded,
                      size: 48, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noResultsFound,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final template = templates[index];
              return _buildTemplateListTile(context, template, l10n);
            },
            childCount: templates.length,
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(48),
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        ),
      ),
      error: (e, _) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Text(l10n.errorLoading,
              style: const TextStyle(color: AppColors.error)),
        ),
      ),
    );
  }

  Widget _buildTemplateListTile(
      BuildContext context, dynamic template, AppLocalizations l10n) {
    final isDepBlocked = ref.watch(templateIsBlockedProvider(template));

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
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
      trailing: isDepBlocked
          ? const Icon(Icons.lock_clock_rounded,
              size: 20, color: AppColors.textSecondary)
          : const Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: AppColors.textSecondary),
      onTap: () {
        if (isDepBlocked) {
          final unmetAsync =
              ref.read(unmetDependencyNamesProvider(template));
          final names = unmetAsync.valueOrNull ?? [];
          final msg = names.isEmpty
              ? 'Complete blocking tasks first.'
              : 'Complete "${names.first}" first.';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
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

  Widget _buildCategoryGrid(
      BuildContext context, AppLocalizations l10n, bool isPremium) {
    final categories = AppConstants.categories;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final category = categories[index];
            final templates =
                ref.watch(templatesByCategoryProvider(category));
            final count = templates.whenOrNull(data: (t) => t.length) ?? 0;

            return _CategoryCardWidget(
              category: category,
              templateCount: count,
              isPremium: isPremium,
              l10n: l10n,
            );
          },
          childCount: categories.length,
        ),
      ),
    );
  }

  void _openHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HistoryScreen()),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  void _openCustomTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CustomTaskScreen()),
    );
  }
}

class _CategoryCardWidget extends StatelessWidget {
  final String category;
  final int templateCount;
  final bool isPremium;
  final AppLocalizations l10n;

  const _CategoryCardWidget({
    required this.category,
    required this.templateCount,
    required this.isPremium,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryScreen(category: category),
          ),
        );
      },
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
              _categoryTitle,
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

  String get _categoryTitle {
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
