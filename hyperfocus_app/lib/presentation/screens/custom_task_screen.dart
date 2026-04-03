import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/models/micro_step.dart';
import '../../domain/models/task_template.dart';
import '../../l10n/app_localizations.dart';
import '../providers/providers.dart';
import 'breakdown_preview_screen.dart';

/// Screen for creating a custom task breakdown.
class CustomTaskScreen extends ConsumerStatefulWidget {
  const CustomTaskScreen({super.key});

  @override
  ConsumerState<CustomTaskScreen> createState() => _CustomTaskScreenState();
}

class _CustomTaskScreenState extends ConsumerState<CustomTaskScreen> {
  final _titleController = TextEditingController();
  final _stepControllers = <TextEditingController>[TextEditingController()];
  String _selectedCategory = 'work';
  // IDs of templates that must complete before this one.
  final List<String> _blockedBy = [];
  static const _uuid = Uuid();

  @override
  void dispose() {
    _titleController.dispose();
    for (final c in _stepControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addStep() {
    setState(() {
      _stepControllers.add(TextEditingController());
    });
  }

  void _removeStep(int index) {
    if (_stepControllers.length <= 1) return;
    setState(() {
      _stepControllers[index].dispose();
      _stepControllers.removeAt(index);
    });
  }

  /// FR-003: Apply generic "Getting Started" 3-step sequence when no custom
  /// steps are provided. The three steps are intentionally absurdly small
  /// to break paralysis and build initial momentum.
  List<String> _gettingStartedSteps(String taskTitle) {
    return [
      'Open whatever you need for "$taskTitle" — just open it, nothing else.',
      'Do the very first, smallest possible thing. Just one thing.',
      'Set a 10-minute timer and keep going — you\'ve already started!',
    ];
  }

  void _applyQuickStart() {
    final title = _titleController.text.trim();
    final steps = _gettingStartedSteps(title.isEmpty ? 'this task' : title);

    // Replace existing empty controllers with quick-start steps
    for (final c in _stepControllers) {
      c.dispose();
    }
    setState(() {
      _stepControllers
        ..clear()
        ..addAll(steps.map((s) {
          final c = TextEditingController(text: s);
          return c;
        }));
    });
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pleaseEnterTitle)),
      );
      return;
    }

    var steps = _stepControllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    // FR-003: If no custom steps, apply generic Getting Started sequence
    if (steps.isEmpty) {
      steps = _gettingStartedSteps(title);
    }

    final template = TaskTemplate(
      id: 'custom_${_uuid.v4()}',
      category: _selectedCategory,
      title: title,
      steps: steps.map((s) => MicroStep.fromText(s)).toList(),
      isCustom: true,
      blockedBy: List.unmodifiable(_blockedBy),
    );

    await ref
        .read(templateRepositoryProvider)
        .insertCustomTemplate(template);

    if (mounted) {
      // Go directly to preview
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BreakdownPreviewScreen(template: template),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createCustomTask),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text(
              l10n.save,
              style: const TextStyle(color: AppColors.secondary),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task title
            Text(
              l10n.taskTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: l10n.taskTitleHint,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            // Category selector
            Text(
              l10n.category,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppConstants.categories.map((cat) {
                final isSelected = cat == _selectedCategory;
                return ChoiceChip(
                  label: Text(_categoryName(cat, l10n)),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  onSelected: (_) {
                    setState(() => _selectedCategory = cat);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            // FR-003: Quick Start — generic 3-step Getting Started sequence
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.quickStart,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.quickStartDescription,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _applyQuickStart,
                      icon: const Icon(Icons.bolt_rounded, size: 18),
                      label: Text(l10n.quickStart),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Steps
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.orAddYourOwn,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton.icon(
                  onPressed: _addStep,
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(l10n.addStep),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              l10n.microStepsHint,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 12),
            ...List.generate(_stepControllers.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(
                      '${index + 1}.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _stepControllers[index],
                        decoration: InputDecoration(
                          hintText: l10n.stepHint,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    if (_stepControllers.length > 1)
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline_rounded,
                            color: AppColors.error, size: 20),
                        onPressed: () => _removeStep(index),
                      ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
            // ── Dependencies section ──────────────────────────────────────
            _DependenciesSection(
              blockedBy: _blockedBy,
              currentTaskId: null, // new task has no ID yet
              onAdd: (id) => setState(() => _blockedBy.add(id)),
              onRemove: (id) => setState(() => _blockedBy.remove(id)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _categoryName(String category, AppLocalizations l10n) {
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
}

// ── Dependencies section widget ────────────────────────────────────────────────

class _DependenciesSection extends ConsumerWidget {
  final List<String> blockedBy;
  final String? currentTaskId;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;

  const _DependenciesSection({
    required this.blockedBy,
    required this.currentTaskId,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTemplatesAsync = ref.watch(allTemplatesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dependencies',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton.icon(
              onPressed: () => _showAddDependencyDialog(context, ref, allTemplatesAsync),
              icon: const Icon(Icons.add_link_rounded, size: 18),
              label: const Text('Add dependency'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'This task cannot start until all dependencies are completed.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        if (blockedBy.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'No dependencies — this task can start anytime.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: allTemplatesAsync.when(
              data: (templates) {
                final titleMap = {for (final t in templates) t.id: t.title};
                return Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: blockedBy.map((id) {
                    final title = titleMap[id] ?? id;
                    return Chip(
                      label: Text(title, overflow: TextOverflow.ellipsis),
                      deleteIcon: const Icon(Icons.close_rounded, size: 16),
                      onDeleted: () => onRemove(id),
                      backgroundColor:
                          AppColors.primary.withValues(alpha: 0.12),
                    );
                  }).toList(),
                );
              },
              loading: () => const SizedBox(
                height: 32,
                child: Center(
                  child: CircularProgressIndicator(
                      color: AppColors.primary, strokeWidth: 2),
                ),
              ),
              error: (e, st) => const SizedBox.shrink(),
            ),
          ),
      ],
    );
  }

  Future<void> _showAddDependencyDialog(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<TaskTemplate>> allTemplatesAsync,
  ) async {
    final templates = allTemplatesAsync.valueOrNull;
    if (templates == null) return;

    // Exclude self and already-added ones.
    final available = templates.where((t) {
      if (currentTaskId != null && t.id == currentTaskId) return false;
      return !blockedBy.contains(t.id);
    }).toList();

    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No more tasks to add as dependencies.')),
      );
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add dependency'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: available.length,
            itemBuilder: (_, index) {
              final t = available[index];
              return ListTile(
                title: Text(t.title),
                subtitle: Text(
                  '${t.stepCount} steps',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                onTap: () {
                  onAdd(t.id);
                  Navigator.pop(ctx);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
