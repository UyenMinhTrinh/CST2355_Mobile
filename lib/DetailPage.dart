import 'package:flutter/material.dart';
import 'todo_item.dart';
import 'database_helper.dart';

class DetailPage extends StatelessWidget {
  final ToDoItem todoItem;

  DetailPage({required this.todoItem});

  @override
  Widget build(BuildContext context) {
    if (todoItem == null) {
      return Center(
        child: Text('No item selected'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${todoItem.name}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text('ID: ${todoItem.id}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Delete item
                DatabaseHelper dbHelper = DatabaseHelper();
                dbHelper.deleteTodoItem(todoItem.id);
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
