import 'package:edu_journal/extended_add_button/add_widget_button_screen.dart';
import 'package:flutter/material.dart';
import 'package:edu_journal/Widgets/attendance_overview.dart';
import 'package:edu_journal/Widgets/cgpa_results.dart';
import 'package:edu_journal/Widgets/semester_syllabus.dart';
import 'package:edu_journal/Widgets/time_table.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class My_Home_Page extends StatefulWidget {
  final String firstName;
  final String lastName;

  My_Home_Page({required this.firstName, required this.lastName});

  @override
  State<My_Home_Page> createState() => _My_Home_PageState();
}

class _My_Home_PageState extends State<My_Home_Page> {
  // List to hold the widgets (Colored Containers)
  final List<Widget> _widgets = [
    AttendanceOverview(),
    CGPA_Results(),
    SemesterSyllabus(),
    TimeTable()
  ];

  // Function to add a new widget (Colored Container)
  void _addWidget(Widget widget) {
    setState(() {
      _widgets.add(widget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/imgs/img_1.png',
              fit: BoxFit.cover,
            ),
          ),
          // Blurred Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
              child: Container(
                color: Colors.black.withOpacity(0.8), // Adjust opacity for better visibility
              ),
            ),
          ),
          // Scrollable Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 60, 0, 40),
                      child: Text(
                        'Edu Journal',
                        style: GoogleFonts.graduate(
                          textStyle: TextStyle(fontSize: 19, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                // User Greeting Row
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.deepPurpleAccent),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Hey, ${widget.firstName}!',
                        style: GoogleFonts.geologica(
                          textStyle: TextStyle(fontSize: 31, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                // Add Widgets (Colored Containers)
                ..._widgets,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Navigate to the Add Widget screen and await for the result
                        final newWidget = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddWidgetScreen(
                              onAddWidget: _addWidget,  // Passing the callback to AddWidgetScreen
                            ),
                          ),
                        );

                        // If a widget was returned, add it to the list
                        if (newWidget != null) {
                          _addWidget(newWidget);
                        }
                      },
                      child: Text('      + Add Widget      '),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.deepPurpleAccent, // Button color
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5, // Elevation (shadow)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
