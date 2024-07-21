import 'package:floor/floor.dart';

@entity
class ToDoItem {
  @primaryKey
  final int id;
  final String name;

  ToDoItem(this.id, this.name);
}
