import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/task_history.dart';
import '../../domain/repositories/history_repository.dart';

class HistoryNotifier
    extends StateNotifier<AsyncValue<List<TaskHistory>>> {
  final HistoryRepository _repository;

  HistoryNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadHistory();
  }

  Future<void> loadHistory() async {
    state = const AsyncValue.loading();
    try {
      final history = await _repository.getAllHistory();
      state = AsyncValue.data(history);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteHistory(String id) async {
    try {
      await _repository.deleteHistory(id);
      await loadHistory();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> clearAllHistory() async {
    try {
      await _repository.clearAllHistory();
      state = const AsyncValue.data([]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
