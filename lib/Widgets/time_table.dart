import 'package:edu_journal/Widgets/timetable_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeTable extends StatefulWidget{
  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.13),
            borderRadius:  BorderRadius.circular(20),
            // border: Border(
            //   top: BorderSide(color: Color(0xFFEDEDED), width: 2.0), // Top border with light gray color
            //   bottom: BorderSide(color: Color(0xFF000000), width: 2.0), // Bottom border with black color
            // ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text('Time Table', style: GoogleFonts.geologica(textStyle: TextStyle(color: Color(0xFFEDEDED), fontSize: 15)),),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the SecondScreen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimeTablePage()),
                  );
                },
                child: Text('      Preview      '),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.deepPurpleAccent,// Button color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  // Padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  elevation: 5, // Elevation (shadow)
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}