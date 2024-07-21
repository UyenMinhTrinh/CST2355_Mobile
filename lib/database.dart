import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'todo_item.dart';
import 'todo_item_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ToDoItem])
abstract class AppDatabase extends FloorDatabase {
  ToDoItemDao get toDoItemDao;
}
