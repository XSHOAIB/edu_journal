import 'package:edu_journal/Add%20Widgets/dead_lines.dart';
import 'package:edu_journal/extended_add_button/add_widget_button_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'todo_list.dart';

class AddWidgets extends StatefulWidget {
  @override
  State<AddWidgets> createState() => _AddWidgetsState();
}

class _AddWidgetsState extends State<AddWidgets> {
  // List of all widgets (ToDoList and DeadLines)
  List<Widget> allWidgets = [
    ToDoList(),
    DeadLines(),
  ];

  // List to hold filtered widgets based on search
  List<Widget> displayedWidgets = [];

  // Controller for search bar
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initially, all widgets are displayed
    displayedWidgets = List.from(allWidgets);
  }

  // Function to filter widgets based on search query
  void _filterWidgets(String query) {
    if (query.isEmpty) {
      setState(() {
        displayedWidgets = List.from(allWidgets);
      });
    } else {
      setState(() {
        // Filter widgets (this can be extended to filter the content of the widgets)
        displayedWidgets = allWidgets.where((widget) {
          if (widget is ToDoList) {
            return 'To-Do List'.toLowerCase().contains(query.toLowerCase());
          } else if (widget is DeadLines) {
            return 'Dead Lines'.toLowerCase().contains(query.toLowerCase());
          }
          return false;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,  // Ensure the background remains black
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 90),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    hintText: "Search Widgets...",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (query) {
                    _filterWidgets(query);
                  },
                ),
              ),
              SizedBox(height: 20),

              // Display the filtered widgets
              if (displayedWidgets.isEmpty)
                Center(
                  child: Text(
                    "No results found",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              else
                Column(
                  children: displayedWidgets,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Search Delegate for more advanced search functionality (optional)
class CustomSearchDelegate extends SearchDelegate {
  // Use the search query to filter
  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Search Suggestions Here...'));
  }

  // When user selects a suggestion
  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('Search Result Here...'));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }
}
