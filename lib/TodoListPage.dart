import 'package:flutter/material.dart';
import 'package:lab2/todo_item_dao.dart';
import 'database.dart';
import 'todo_item.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _textController = TextEditingController();
  final List<ToDoItem> _todoItems = [];
  late AppDatabase _database;
  late ToDoItemDao _toDoItemDao;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    _toDoItemDao = _database.toDoItemDao;
    _loadToDoItems();
  }

  Future<void> _loadToDoItems() async {
    final items = await _toDoItemDao.findAllToDoItems();
    setState(() {
      _todoItems.clear();
      _todoItems.addAll(items);
    });
  }

  void _addToDoItem(String item) async {
    final newToDo = ToDoItem(_todoItems.length, item);  // You might want a better ID management
    await _toDoItemDao.insertToDoItem(newToDo);
    _textController.clear();
    _loadToDoItems(); // Reload the list to include the new item
  }

  void _removeToDoItem(int id) async {
    final item = _todoItems.firstWhere((item) => item.id == id);
    await _toDoItemDao.deleteToDoItem(item);
    _loadToDoItems(); // Reload the list to exclude the deleted item
  }

  void _promptRemoveToDoItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove ToDo Item'),
        content: Text('Are you sure you want to delete "${_todoItems[index].name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              _removeToDoItem(_todoItems[index].id);
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Enter a todo item',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      _addToDoItem(_textController.text);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _todoItems.isEmpty
                ? Center(child: Text('There are no items in the list'))
                : ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Row number: $index'),
                  subtitle: Text(_todoItems[index].name),
                  onLongPress: () => _promptRemoveToDoItem(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
