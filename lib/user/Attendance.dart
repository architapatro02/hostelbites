import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/components/togglebuttonform.dart';

class MarkedAttendancePage extends StatefulWidget {
  const MarkedAttendancePage({Key? key}) : super(key: key);

  @override
  _MarkedAttendancePageState createState() =>  _MarkedAttendancePageState();
}

class _MarkedAttendancePageState  extends State<MarkedAttendancePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown[500],
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle_rounded),
            SizedBox(width: 2),
            Text('Attendance',)
          ],),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(height: 200,
              color: Colors.brown[300],
              child: Center(
                child: Text('MARK ATTENDANCE',
                    style:GoogleFonts.roboto(fontSize: 40,),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          SizedBox(height: 20),
          //enter the toggle button form
          ToggleButtonForm(),
        ],
      ),
    );
  }
}
