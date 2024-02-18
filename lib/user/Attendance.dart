import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/user/togglebuttonform.dart';
//import 'package:google_fonts/google_fonts.dart';

class MarkedAttendancePage extends StatefulWidget {
  const MarkedAttendancePage({Key? key}) : super(key: key);

  @override
  _MarkedAttendancePageState createState() =>  _MarkedAttendancePageState();
}

class _MarkedAttendancePageState  extends State<MarkedAttendancePage>{
  // bool isBreakfastSelected =false;
  // bool isLunchSelected = false;
  // bool isSnacksSelected = false;
  // bool isDinnerSelected = false;


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
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 25),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('BREAKFAST', style: TextStyle(fontSize: 25)),
          //       Switch(
          //         value: isBreakfastSelected,
          //         onChanged: (value) {
          //           setState(() {
          //             isBreakfastSelected = value;
          //           });
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 20),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 25),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('LUNCH', style: TextStyle(fontSize: 25)),
          //       Switch(
          //         value: isLunchSelected,
          //         onChanged: (value) {
          //           setState(() {
          //             isLunchSelected = value;
          //           });
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 20),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 25),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('SNACKS', style: TextStyle(fontSize: 25)),
          //       Switch(
          //         value: isSnacksSelected,
          //         onChanged: (value) {
          //           setState(() {
          //             isSnacksSelected = value;
          //           });
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 20),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 25),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('DINNER', style: TextStyle(fontSize: 25)),
          //       Switch(
          //         value: isDinnerSelected,
          //         onChanged: (value) {
          //           setState(() {
          //             isDinnerSelected = value;
          //           });
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          // ToggleButtonWidget(),
          // SizedBox(height: 30),
          // ElevatedButton(
          //   onPressed: () {
          //     // Add submit functionality here
          //   },
          //   child: Text('SUBMIT'),
          // ),

        ],
      ),


    );
  }
}
