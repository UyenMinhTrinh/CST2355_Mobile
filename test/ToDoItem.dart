
import 'dart:ffi';
import 'ToDoItem.dart';
import 'package:floor/floor.dart';

@entity
class ToDoItem {

  @primaryKey
  final int id;

  final String name;

  ToDoItem(this.id, this.name);

}

@dao
abstract class ToDoItemDAO {
  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> findAllToDoItems();

  @delete
  Future<int> deleteToDoItem(ToDoItem p);

  @insert
  Future<int> insertToDoItem(ToDoItem toDoItem);

}