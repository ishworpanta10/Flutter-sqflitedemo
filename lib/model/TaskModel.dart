import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "todo_db";
final String columnId = 'id';
final String columnName = 'name';

//todo: columnName and constructor need to be same

class TaskModel {
  final String name;
  int id;

  TaskModel({this.name, this.id});

  Map<String, dynamic> toMap() {
    return {
      columnName: this.name
    }; //todo: column name and constrictor need to be same
  }
}

class TodoHelper {
  Database db;

  TodoHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "my_db.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT , $columnName TEXT)");
    }, version: 2);
  }

  Future<void> insertTask(TaskModel task) async {
    try {
      db.insert(tableName, task.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
    }
  }

  Future<List<TaskModel>> getallTask() async {
    final List<Map<String, dynamic>> tasks = await db.query(tableName);

    return List.generate(tasks.length, (index) {
      return TaskModel(
          name: tasks[index][columnName], id: tasks[index][columnId]);
    });
  }
}
