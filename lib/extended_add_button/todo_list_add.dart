import 'package:edu_journal/Add%20Widgets/todo_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edu_journal/Add%20Widgets/dead_lines.dart';

class TodoListAdd extends StatefulWidget {
  final Function(Widget) onAddWidget;

  TodoListAdd({required this.onAddWidget});

  @override
  State<TodoListAdd> createState() => _TodoListAddState();
}

class _TodoListAddState extends State<TodoListAdd> {
  List<String> todoItems = [
    'Buy groceries',
    'Complete Flutter project',
    'Go for a run',
    'Call mom',
    'Read a book'
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.13),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'ToDo List',
                  style: GoogleFonts.geologica(
                    textStyle: TextStyle(
                      color: Color(0xFFEDEDED),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Create a new widget (DeadLines)
                    Widget newWidget = ToDoList();

                    // Add the widget to the home screen via the callback
                    widget.onAddWidget(newWidget);

                    // Pop to return to the HomePage
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      // Optionally, handle the case where there's nothing to pop
                      print("No screen to pop from the stack.");
                    }
                  },
                  child: Text('Add Widget'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
