import 'package:edu_journal/auth_field.dart';
import 'package:edu_journal/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserFormScreen extends StatefulWidget {
  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  // This function handles form submission and navigation
  void _submitForm() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;

    // Check if both fields are filled
    if (firstName.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter atleast first name')),
      );
      return;
    }

    // Forward data to the next screen using Navigator
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          firstName: firstName,
          lastName: lastName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60,),
              Text(
                'Edu Journal',
                style: GoogleFonts.graduate(
                  textStyle: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
              SizedBox(height: 250,),
              AuthField(hintText: 'First Name', controller: _firstNameController),
              SizedBox(height: 20,),
              AuthField(hintText: 'Last Name / Optional', controller: _lastNameController),
              SizedBox(height: 40),
          
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Les goo!"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.05),
                  foregroundColor: Colors.deepPurpleAccent,// Button color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  elevation: 5, // Elevation (shadow)
                ),
              ),
              SizedBox(height: 300,),
            ],
          ),
        ),
      ),
    );
  }
}
