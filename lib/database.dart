// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'ToDoItemDAO.dart';
import 'ToDoItem.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ToDoItem])
abstract class database extends FloorDatabase {
  ToDoItemDAO get toDoItemDao;
}