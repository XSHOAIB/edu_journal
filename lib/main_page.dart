import 'package:edu_journal/Add%20Widgets/add_widgets.dart';
import 'package:edu_journal/MyHomePage.dart';
import 'package:edu_journal/chat%20bot/chat_screen.dart';
import 'package:edu_journal/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPage extends StatefulWidget{



  final String firstName;
  final String lastName;

  MainPage({required this.firstName, required this.lastName});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _screens(){
    return[
      My_Home_Page(firstName: widget.firstName, lastName: widget.lastName),
      AddWidgets(),
      ChatScreen(),
      //ProfilePage(firstName: widget.firstName, lastName: widget.lastName),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems(){
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.deepPurpleAccent,
        inactiveColorPrimary: Colors.white60,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        title: "Widgets",
        activeColorPrimary: Colors.deepPurpleAccent,
        inactiveColorPrimary: Colors.white60,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.deepPurpleAccent,
        inactiveColorPrimary: Colors.white60,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        screens: _screens(),
      items: navBarItems(),
      controller: _controller,
      navBarStyle: NavBarStyle.style9,
      handleAndroidBackButtonPress: true,
      backgroundColor: Colors.black,
      //stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),

    );
  }
}