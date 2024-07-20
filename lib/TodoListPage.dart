import 'package:flutter/material.dart';
import 'database_helper.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _todoItems = [];

  @override
  void initState() {
    super.initState();
    _loadTodoItems();
  }

  Future<void> _loadTodoItems() async {
    final items = await DatabaseHelper().getTodoItems();
    setState(() {
      _todoItems.addAll(items);
    });
  }

  void _addTodoItem(String item) async {
    await DatabaseHelper().insertTodoItem(item);
    _textController.clear();
    _loadTodoItems(); // Reload the list to include the new item
  }

  void _removeTodoItem(int id) async {
    await DatabaseHelper().deleteTodoItem(id);
    _loadTodoItems(); // Reload the list to exclude the deleted item
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Todo Item'),
        content: Text('Are you sure you want to delete "${_todoItems[index]['item']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              _removeTodoItem(_todoItems[index]['id']);
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
                      _addTodoItem(_textController.text);
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
                  subtitle: Text(_todoItems[index]['item']),
                  onLongPress: () => _promptRemoveTodoItem(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
