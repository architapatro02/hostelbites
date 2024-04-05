import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/components/togglebuttonform.dart';

class MarkedAttendancePage extends StatefulWidget {
  const MarkedAttendancePage({Key? key}) : super(key: key);

  @override
  _MarkedAttendancePageState createState() => _MarkedAttendancePageState();
}

class _MarkedAttendancePageState extends State<MarkedAttendancePage> {
  bool _isTimeToMarkAttendance() {
    // Get the current time
    final currentTime = DateTime.now().toLocal();

    // Check if the current time is between 9 PM and 6 AM
    return currentTime.hour >= 21 || currentTime.hour < 6;
  }

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
            Text(
              'Attendance',
              style: GoogleFonts.actor(fontSize: 20),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.brown[300],
              ),
              child: Center(
                child: Text(
                  'MARK ATTENDANCE',
                  style: GoogleFonts.actor(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          if (_isTimeToMarkAttendance())
            ToggleButtonForm()
          else
            Center(
              child: Text(
                'Attendance should be marked between 9 PM and 6 AM',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
