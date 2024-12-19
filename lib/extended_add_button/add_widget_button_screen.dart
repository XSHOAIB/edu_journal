import 'package:edu_journal/Add%20Widgets/todo_list.dart';
import 'package:edu_journal/extended_add_button/deadlines_add.dart';
import 'package:edu_journal/extended_add_button/todo_list_add.dart';
import 'package:flutter/material.dart';

class AddWidgetScreen extends StatefulWidget {
  final Function(Widget) onAddWidget;

  AddWidgetScreen({required this.onAddWidget});

  @override
  State<AddWidgetScreen> createState() => _AddWidgetScreenState();
}

class _AddWidgetScreenState extends State<AddWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              // Pass the onAddWidget function from the HomePage to DeadLinesAdd
              DeadLinesAdd(
                onAddWidget: (Widget newWidget) {
                  // Return the new widget to the HomePage
                  widget.onAddWidget(newWidget);  // Add the widget in HomePage
                  Navigator.pop(context);  // Pop to go back to the HomePage
                },
              ),
              TodoListAdd(
                onAddWidget: (Widget newWidget) {
                  // Return the new widget to the HomePage
                  widget.onAddWidget(newWidget);  // Add the widget in HomePage
                  Navigator.pop(context);  // Pop to go back to the HomePage
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
