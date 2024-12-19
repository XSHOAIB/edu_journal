import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Timetable',
      theme: ThemeData.dark(),
      home: TimetablePage(),
    );
  }
}

class TimetablePage extends StatefulWidget {
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  // List of time slots
  final List<String> timeSlots = [
    '9:15 AM - 10:15 AM',
    '10:15 AM - 11:15 AM',
    '11:15 AM - 12:15 PM',
    '12:15 PM - 1:15 PM',
    '2:00 PM - 3:00 PM',
    '3:00 PM - 4:00 PM',
  ];

  // Timetable data for each day of the week
  final Map<String, List<String>> timetable = {
    'Monday': List.generate(6, (_) => ''),
    'Tuesday': List.generate(6, (_) => ''),
    'Wednesday': List.generate(6, (_) => ''),
    'Thursday': List.generate(6, (_) => ''),
    'Friday': List.generate(6, (_) => ''),
    'Saturday': List.generate(6, (_) => ''),
  };

  // TextEditingControllers for each cell (day/time slot)
  final Map<String, List<TextEditingController>> controllers = {};

  // State variable to switch between Edit and Preview modes
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadTimetableData();
  }

  // Initialize controllers for each day and time slot
  void _initializeControllers() {
    for (var day in timetable.keys) {
      controllers[day] = List.generate(6, (_) => TextEditingController());
    }
  }

  // Load timetable data from SharedPreferences
  Future<void> _loadTimetableData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedData = prefs.getStringList('timetable');

    if (savedData != null) {
      setState(() {
        for (int i = 0; i < savedData.length; i++) {
          final parts = savedData[i].split('|');
          String day = parts[0];
          String subject = parts[1];
          int slot = int.parse(parts[2]);

          // Update timetable with saved subjects
          timetable[day]![slot] = subject;
        }
      });
    }

    // Initialize controllers with saved data
    for (var day in timetable.keys) {
      for (int i = 0; i < 6; i++) {
        controllers[day]![i].text = timetable[day]?[i] ?? ''; // Safe null check
      }
    }
  }

  // Save timetable data to SharedPreferences
  Future<void> _saveTimetableData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedData = [];

    // Save each day and time slot data as a string
    for (var day in timetable.keys) {
      for (int i = 0; i < 6; i++) {
        if (controllers[day]?[i].text.isNotEmpty ?? false) { // Safe null check
          savedData.add('$day|${controllers[day]?[i].text}|$i');
        }
      }
    }

    prefs.setStringList('timetable', savedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Timetable'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Toggle between Preview and Edit modes
            _isEditing ? _buildEditableTimetable() : _buildPreviewTimetable(),
            SizedBox(height: 20),
            // Button to toggle between Preview and Edit modes
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              child: Text(_isEditing ? 'Switch to Preview Mode' : 'Edit Timetable'),
            ),
            SizedBox(height: 20),
            // Button to save data (always available)
            ElevatedButton(
              onPressed: _saveTimetableData,
              child: Text('Save Timetable'),
            ),
          ],
        ),
      ),
    );
  }

  // Build the timetable in Preview Mode
  Widget _buildPreviewTimetable() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var day in timetable.keys)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Divider(color: Colors.white),
                        for (int i = 0; i < timeSlots.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    timeSlots[i],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    timetable[day]![i].isEmpty
                                        ? 'No Subject'
                                        : timetable[day]![i],
                                    style: TextStyle(
                                      color: timetable[day]![i].isEmpty
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Build the timetable in Edit Mode (editable fields)
  Widget _buildEditableTimetable() {
    return Expanded(
      child: Table(
        border: TableBorder.all(color: Colors.white),
        children: [
          // Header Row (Days of the week)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Time Slot', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              for (var day in timetable.keys)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(day, style: TextStyle(fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          // Time Slot Rows
          for (int i = 0; i < timeSlots.length; i++)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(timeSlots[i]),
                ),
                for (var day in timetable.keys)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controllers[day]?[i], // Safe access to controller
                      decoration: InputDecoration(hintText: 'Enter subject'),
                      onChanged: (value) {
                        setState(() {
                          timetable[day]![i] = value;
                        });
                      },
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
