
import 'package:flutter/material.dart';




class ProfilePage extends StatefulWidget {

  final String firstName;
  final String lastName;

  ProfilePage({required this.firstName, required this.lastName});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex:5,
                child:Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black,Colors.deepPurple.shade900,Colors.black],
                        stops: [0.1, 0.3, 0.5],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                    ),
                  ),
                  child: Column(
                      children: [
                        SizedBox(height: 150.0,),
                        CircleAvatar(
                          radius: 65.0,
                          backgroundImage: AssetImage('assets/erza.jpg'),
                          backgroundColor: Colors.black,
                          child: Container(
                        decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white, // Border color
                          width: 4.0, // Border width
                          ),
                            shape: BoxShape.circle,
                          ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Text('${widget.firstName} ${widget.lastName}',
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 20.0,
                            )),
                        SizedBox(height: 10.0,),
                        Text('Student',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 15.0,
                          ),)
                      ]
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


