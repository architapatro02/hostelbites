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

  Widget _buildHeader() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.brown[900],
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(
              'assets/images/attendance.jpg'), // Replace 'assets/background_image.jpg' with your image asset path
          fit: BoxFit.cover,
        ),
      ),
    );
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
          _buildHeader(),
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
