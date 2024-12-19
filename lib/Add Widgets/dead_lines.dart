import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting

class DeadLines extends StatefulWidget {
  @override
  State<DeadLines> createState() => _DeadLinesState();
}

class _DeadLinesState extends State<DeadLines> {
  // List to hold deadline items
  List<Map<String, String>> deadlineItems = [
    {'task': 'AI Record', 'date': '2-12-2024'},
    {'task': 'DIP Assignment', 'date': '5-12-2024'},
    {'task': 'DIP Record', 'date': '6-12-2024'},
    {'task': 'AI Assignment', 'date': '7-12-2024'},
    {'task': 'SS Manual', 'date': '8-12-2024'},
    {'task': 'SDC Project', 'date': '10-12-2024'},
    {'task': 'Observations', 'date': '12-12-2024'},
  ];

  // Function to add a new task to the list
  void _addTask(String task, String date) {
    setState(() {
      deadlineItems.add({'task': task, 'date': date});
    });
  }

  // Function to show dialog for adding new task
  void _showAddTaskDialog() {
    String task = '';
    String date = '';
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
              TextField(
                onChanged: (value) {
                  date = value;
                },
                readOnly: true, // Disable typing in the date field
                decoration: InputDecoration(
                  labelText: 'Due Date',
                  hintText: 'Select Date',
                  suffixIcon: Icon(Icons.calendar_today), // Add calendar icon
                ),
                onTap: () async {
                  // Show Date Picker on tap
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015), // Earliest date
                    lastDate: DateTime(2101), // Latest date
                  );

                  if (pickedDate != null) {
                    // Format the selected date as a string using intl package
                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    setState(() {
                      date = formattedDate; // Update date field with selected date
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // If both fields are filled, add the task
                if (task.isNotEmpty && date.isNotEmpty) {
                  _addTask(task, date);
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
          height: 430,
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
                  'Dead Lines',
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
                  padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                  child: ListView.builder(
                    itemCount: deadlineItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('${deadlineItems[index]['task']}',
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text('${deadlineItems[index]['date']}',
                            style: TextStyle(color: Colors.white, fontSize: 13)),
                        trailing: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              // Remove item on long press
                              deadlineItems.removeAt(index);
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
