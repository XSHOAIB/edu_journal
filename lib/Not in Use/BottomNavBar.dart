import 'package:edu_journal/Add%20Widgets/add_widgets.dart';
import 'package:edu_journal/MyHomePage.dart';
import 'package:edu_journal/profile_page.dart';
import 'package:flutter/material.dart';


class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  // A method to change the currently selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the corresponding screen based on the index
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => My_Home_Page(firstName: "", lastName: "")),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AddWidgets()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage(firstName: '', lastName: "")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add,),
            label: 'Widgets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Highlight the selected item
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurpleAccent, // Color for selected item
        unselectedItemColor: Colors.white54, // Color for unselected item
        backgroundColor: Colors.black,
    );
  }
}
class SelectedIndex with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();  // Notifies all listeners (pages) about the update
  }
}