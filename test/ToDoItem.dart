
import 'dart:ffi';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';

@entity
class ToDoItem {

  @primaryKey
  final int id;

  final String name;

  ToDoItem(this.id, this.name);

}

@dao
abstract class ToDoItemDao {
  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> findAllToDoItems();

  @Query('SELECT * FROM ToDoItem WHERE id = :id')
  Stream<ToDoItem?> findToDoItemById(int id);

  @insert
  Future<Long> insertToDoItem(ToDoItem toDoItem);

}