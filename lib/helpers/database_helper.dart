
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart'; // Corregido: Importa el modelo Task desde su propio archivo

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, isCompleted INTEGER)',
        );
      },
    );
  }

  // Inserta una nueva tarea
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  // Obtiene todas las tareas
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task(
        title: maps[i]['title'],
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }

  // Actualiza una tarea
  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'title = ?', // Asumimos que el título es único por simplicidad
      whereArgs: [task.title],
    );
  }

  // Elimina una tarea
  Future<int> deleteTask(String title) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'title = ?',
      whereArgs: [title],
    );
  }
}
