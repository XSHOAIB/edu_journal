import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoList extends StatefulWidget {
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  // List to hold to-do items
  List<String> todoItems = [
    'Buy groceries',
    'Complete Flutter project',
    'Go for a run',
    'Call mom',
    'Read a book',
  ];

  // Function to add a new task to the list
  void _addTask(String task) {
    setState(() {
      todoItems.add(task);
    });
  }

  // Function to show dialog for adding a new task
  void _showAddTaskDialog() {
    String task = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  task = value;
                },
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // If the task field is not empty, add the task
                if (task.isNotEmpty) {
                  _addTask(task);
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          height: 450, // Define a specific height for the container
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.13),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(
                  'To-Do List',
                  style: GoogleFonts.geologica(
                    textStyle: TextStyle(
                      color: Color(0xFFEDEDED),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 20, 20),
                  child: ListView.builder(
                    itemCount: todoItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        title: Text(todoItems[index], style: TextStyle(color: Colors.white)),
                        trailing: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              // Remove item on long press
                              todoItems.removeAt(index);
                            });
                          },
                          child: Icon(Icons.delete, color: Colors.red[900]),
                        ),
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _showAddTaskDialog, // Open dialog to add a new task
                child: Text('Add Task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  "Long press on delete button to remove a task.",
                  style: GoogleFonts.geologica(
                    textStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
