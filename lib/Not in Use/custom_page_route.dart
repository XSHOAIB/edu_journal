import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  // Constructor to accept the page and optional route settings
  CustomPageRoute({
    required this.page,
    RouteSettings? settings, // Optional settings argument
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    settings: settings ?? RouteSettings(), // Use provided settings or default to RouteSettings()
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide transition animation from right to left
      const begin = Offset(1.0, 0.0); // Slide from right to left
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
    transitionDuration: Duration(milliseconds: 500), // Duration of the transition
  );
}
