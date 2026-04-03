import '../../domain/models/task_history.dart';
import '../../domain/repositories/history_repository.dart';
import '../database/app_database.dart';

class SqliteHistoryRepository implements HistoryRepository {
  final AppDatabase _db;

  SqliteHistoryRepository(this._db);

  @override
  Future<List<TaskHistory>> getAllHistory() async {
    final db = await _db.database;
    final maps =
        await db.query('task_history', orderBy: 'completed_at DESC');
    return maps.map((m) => TaskHistory.fromMap(m)).toList();
  }

  @override
  Future<List<TaskHistory>> getRecentHistory({int limit = 20}) async {
    final db = await _db.database;
    final maps = await db.query(
      'task_history',
      orderBy: 'completed_at DESC',
      limit: limit,
    );
    return maps.map((m) => TaskHistory.fromMap(m)).toList();
  }

  @override
  Future<void> insertHistory(TaskHistory history) async {
    final db = await _db.database;
    await db.insert('task_history', history.toMap());
  }

  @override
  Future<void> deleteHistory(String id) async {
    final db = await _db.database;
    await db.delete('task_history', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> clearAllHistory() async {
    final db = await _db.database;
    await db.delete('task_history');
  }

  @override
  Future<int> getCompletedTaskCount() async {
    final db = await _db.database;
    final result =
        await db.rawQuery('SELECT COUNT(*) as count FROM task_history');
    return result.first['count'] as int;
  }

  @override
  Future<int> getTotalStepsCompleted() async {
    final db = await _db.database;
    final result = await db.rawQuery(
        'SELECT COALESCE(SUM(completed_steps), 0) as total FROM task_history');
    return result.first['total'] as int;
  }
}
