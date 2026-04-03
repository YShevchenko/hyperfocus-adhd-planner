import '../models/task_history.dart';

abstract class HistoryRepository {
  Future<List<TaskHistory>> getAllHistory();
  Future<List<TaskHistory>> getRecentHistory({int limit = 20});
  Future<void> insertHistory(TaskHistory history);
  Future<void> deleteHistory(String id);
  Future<void> clearAllHistory();
  Future<int> getCompletedTaskCount();
  Future<int> getTotalStepsCompleted();
}
