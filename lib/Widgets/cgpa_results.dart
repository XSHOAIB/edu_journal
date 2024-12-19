import 'package:edu_journal/Widgets/cgpa_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CGPA_Results extends StatefulWidget{
  @override
  State<CGPA_Results> createState() => _CGPA_ResultsState();
}

class _CGPA_ResultsState extends State<CGPA_Results> {


  double cgpa_res = 7.23;
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
                child: Text('CGPA & Results', style: GoogleFonts.geologica(textStyle: TextStyle(color: Color(0xFFEDEDED), fontSize: 15)),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 30, 50, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Text(' $cgpa_res\nCGPA',style: GoogleFonts.geologica(textStyle: TextStyle(color: Colors.grey, fontSize:25)),),
                    SizedBox(width: 20,),
                    //Container(height: 100,width: 2,color: Colors.grey,),
                    SizedBox(width: 25,),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the SecondScreen when the button is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SGPA_CGPA_Page()),
                        );
                      },                        child: Text('Enter Marks'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.deepPurpleAccent,// Button color
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                        elevation: 5, // Elevation (shadow)
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text("don't limit the cross, marks define not you", style: GoogleFonts.geologica(textStyle: TextStyle(color: Colors.grey, fontSize: 10)),),
              ),
              SizedBox(height: 8,)
            ],
          ),
        ),
      ),
    );
  }
}