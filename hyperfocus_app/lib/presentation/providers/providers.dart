import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/database/app_database.dart';
import '../../data/repositories/asset_template_repository.dart';
import '../../data/repositories/sqlite_history_repository.dart';
import '../../domain/models/active_task.dart';
import '../../domain/models/task_history.dart';
import '../../domain/models/task_template.dart';
import '../../domain/repositories/history_repository.dart';
import '../../domain/repositories/template_repository.dart';
import '../../domain/services/template_service.dart';
import '../../domain/services/timer_service.dart';
import '../../services/ad_service.dart';
import '../../services/audio_service.dart';
import '../../services/iap_service.dart';
import 'history_notifier.dart';
import 'settings_notifier.dart';
import 'task_notifier.dart';

// Database
final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

// Services
final templateServiceProvider =
    Provider<TemplateService>((ref) => TemplateService());

final timerServiceProvider =
    Provider<TimerService>((ref) => TimerService());

final adServiceProvider = Provider<AdService>((ref) => AdService());

final iapServiceProvider = Provider<IapService>((ref) => IapService());

final audioServiceProvider =
    Provider<AudioService>((ref) => AudioService());

// Repositories
final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  return AssetTemplateRepository(
    ref.read(templateServiceProvider),
    ref.read(appDatabaseProvider),
  );
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return SqliteHistoryRepository(ref.read(appDatabaseProvider));
});

// Premium state
final isPremiumProvider = StateProvider<bool>((ref) => false);

// Settings
final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});

// Templates
final allTemplatesProvider =
    FutureProvider<List<TaskTemplate>>((ref) async {
  final repo = ref.read(templateRepositoryProvider);
  return repo.getAllTemplates();
});

final templatesByCategoryProvider =
    FutureProvider.family<List<TaskTemplate>, String>(
        (ref, category) async {
  final repo = ref.read(templateRepositoryProvider);
  return repo.getTemplatesByCategory(category);
});

final templateSearchProvider =
    FutureProvider.family<List<TaskTemplate>, String>((ref, query) async {
  if (query.isEmpty) return [];
  final repo = ref.read(templateRepositoryProvider);
  return repo.searchTemplates(query);
});

// Active task
final taskNotifierProvider =
    StateNotifierProvider<TaskNotifier, ActiveTask?>((ref) {
  return TaskNotifier(
    ref.read(historyRepositoryProvider),
    ref.read(adServiceProvider),
  );
});

// History
final historyNotifierProvider =
    StateNotifierProvider<HistoryNotifier, AsyncValue<List<TaskHistory>>>(
        (ref) {
  return HistoryNotifier(ref.read(historyRepositoryProvider));
});

// Stats
final completedTaskCountProvider = FutureProvider<int>((ref) async {
  final repo = ref.read(historyRepositoryProvider);
  return repo.getCompletedTaskCount();
});

final totalStepsCompletedProvider = FutureProvider<int>((ref) async {
  final repo = ref.read(historyRepositoryProvider);
  return repo.getTotalStepsCompleted();
});

// Shared preferences
final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

// Set of template IDs that have been completed at least once (for dependency checks).
final completedTemplateIdsProvider = Provider<Set<String>>((ref) {
  final historyAsync = ref.watch(historyNotifierProvider);
  return historyAsync.whenOrNull(
        data: (history) => history.map((h) => h.templateId).toSet(),
      ) ??
      {};
});

// Returns true if all blocking tasks for [templateId] have been completed.
final templateIsBlockedProvider =
    Provider.family<bool, TaskTemplate>((ref, template) {
  if (template.blockedBy.isEmpty) return false;
  final completedIds = ref.watch(completedTemplateIdsProvider);
  return template.blockedBy.any((id) => !completedIds.contains(id));
});

// Blocking task name lookup: returns names of unmet dependencies.
final unmetDependencyNamesProvider =
    FutureProvider.family<List<String>, TaskTemplate>(
        (ref, template) async {
  if (template.blockedBy.isEmpty) return [];
  final completedIds = ref.watch(completedTemplateIdsProvider);
  final unmetIds =
      template.blockedBy.where((id) => !completedIds.contains(id)).toList();
  if (unmetIds.isEmpty) return [];
  final repo = ref.read(templateRepositoryProvider);
  final names = <String>[];
  for (final id in unmetIds) {
    final t = await repo.getTemplateById(id);
    if (t != null) names.add(t.title);
  }
  return names;
});
