import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AttendanceOverview extends StatefulWidget{
  @override
  State<AttendanceOverview> createState() => _AttendanceOverviewState();
}

class _AttendanceOverviewState extends State<AttendanceOverview> {
  int _percentage = 54;
  double _sliderValue = 1.0;
  @override
  Widget build(BuildContext context) {
    double progressWidth = (200 * _percentage) / 100;
    int _slider_value = _sliderValue.toInt();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.13),
              borderRadius:  BorderRadius.circular(20),
              // border: Border(
              //   top: BorderSide(color: Color(0xFFEDEDED), width: 2.0), // Top border with light gray color
              //   bottom: BorderSide(color: Color(0xFF000000), width: 2.0), // Bottom border with black color
            // ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.2), // Shadow color with opacity
            //     spreadRadius: 5, // The spread of the shadow
            //     blurRadius: 10,  // How blurry the shadow is
            //     offset: Offset(0, 4), // Horizontal and Vertical offset of the shadow
            //   ),
            // ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text('Attendance Overview', style: GoogleFonts.geologica(textStyle: TextStyle(color: Color(0xFFEDEDED), fontSize: 15)),),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$_percentage%',style: GoogleFonts.geologica(textStyle: TextStyle(color: Color(0xFFEDEDED), fontSize: 30, fontWeight: FontWeight.bold))),
                  SizedBox(width: 20,),
                  Stack(
                    children: [
                      Container(height: 20, width: 200, decoration: BoxDecoration( borderRadius: BorderRadius.circular(10), color: Colors.grey[800]),),
                      Container(height: 20, width: progressWidth, decoration: BoxDecoration( borderRadius: BorderRadius.circular(10), color: Colors.deepPurpleAccent),)
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 340,
                  child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.grey,  // Active track color (filled part)
                        inactiveTrackColor: Colors.grey[800], // Inactive track color (unfilled part)
                        thumbColor: Colors.deepPurpleAccent,          // Thumb color (draggable part)
                        overlayColor: Colors.blue.withAlpha(32), // Overlay color when pressed
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0), // Thumb shape
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                      ),
                      child: Slider(
                        value: _sliderValue,  // Current slider value
                        min: 0.0,             // Minimum value of the slider
                        max: 6.0,             // Maximum value of the slider (set to 6)
                        divisions: 6,         // Set divisions to 6, so you get 7 discrete values (0, 1, 2, 3, 4, 5, 6)
                        label: _sliderValue.toStringAsFixed(1),  // Display the value with one decimal place
                        onChanged: (double newValue) {
                          setState(() {
                            _sliderValue = newValue.clamp(0.0, 6.0);  // Update the slider value
                          });
                        },
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 30, 50, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('   $_slider_value Hour \n Attended',style: GoogleFonts.geologica(textStyle: TextStyle(color: Colors.grey, fontSize: 20)),),
                    SizedBox(width: 20,),
                    Container(height: 100,width: 2,color: Colors.grey,),
                    SizedBox(width: 25,),
                    Text('${DateFormat('dd MMM, \n yyyy').format(DateTime.now())}',style: GoogleFonts.geologica(textStyle: TextStyle(color: Colors.grey, fontSize: 20)),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text('drag the slider, as per attended hours', style: GoogleFonts.geologica(textStyle: TextStyle(color: Colors.grey, fontSize: 10)),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
