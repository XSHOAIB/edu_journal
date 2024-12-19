import 'package:edu_journal/user_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // Navigate to HomeScreen after a delay (for splash effect)
  Future<void> _navigateToHome() async {
    await Future.delayed(Duration(seconds: 1 ));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserFormScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: 'hero-logo',  // This tag will be used for the Hero animation
          child: Material(
            color: Colors.transparent,  // Make sure the background is transparent
            child: Image.asset("assets/imgs/BS.png", fit: BoxFit.cover,),
          ),
        ),
      ),
    );
  }
}
