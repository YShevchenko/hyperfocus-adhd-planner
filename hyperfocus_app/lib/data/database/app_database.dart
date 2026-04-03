import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/constants.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._();
  factory AppDatabase() => _instance;
  AppDatabase._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, AppConstants.databaseName);
    return openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE custom_templates (
        id TEXT PRIMARY KEY,
        category TEXT NOT NULL,
        title TEXT NOT NULL,
        steps TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE task_history (
        id TEXT PRIMARY KEY,
        template_id TEXT NOT NULL,
        title TEXT NOT NULL,
        category TEXT NOT NULL,
        total_steps INTEGER NOT NULL,
        completed_steps INTEGER NOT NULL,
        started_at TEXT NOT NULL,
        completed_at TEXT NOT NULL,
        duration_seconds INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE task_dependencies (
        task_id TEXT NOT NULL,
        depends_on_id TEXT NOT NULL,
        PRIMARY KEY (task_id, depends_on_id)
      )
    ''');

    await db.execute(
        'CREATE INDEX idx_history_completed ON task_history(completed_at)');
    await db.execute(
        'CREATE INDEX idx_history_category ON task_history(category)');
    await db.execute(
        'CREATE INDEX idx_custom_templates_category ON custom_templates(category)');
    await db.execute(
        'CREATE INDEX idx_task_dependencies_task_id ON task_dependencies(task_id)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE task_dependencies (
          task_id TEXT NOT NULL,
          depends_on_id TEXT NOT NULL,
          PRIMARY KEY (task_id, depends_on_id)
        )
      ''');
      await db.execute(
          'CREATE INDEX idx_task_dependencies_task_id ON task_dependencies(task_id)');
    }
  }

  // ── Dependency helpers ──────────────────────────────────────────────────────

  Future<void> addDependency(String taskId, String dependsOnId) async {
    final db = await database;
    await db.insert(
      'task_dependencies',
      {'task_id': taskId, 'depends_on_id': dependsOnId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> removeDependency(String taskId, String dependsOnId) async {
    final db = await database;
    await db.delete(
      'task_dependencies',
      where: 'task_id = ? AND depends_on_id = ?',
      whereArgs: [taskId, dependsOnId],
    );
  }

  Future<List<String>> getDependencies(String taskId) async {
    final db = await database;
    final rows = await db.query(
      'task_dependencies',
      columns: ['depends_on_id'],
      where: 'task_id = ?',
      whereArgs: [taskId],
    );
    return rows.map((r) => r['depends_on_id'] as String).toList();
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
