import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ToggleButtonForm extends StatefulWidget {
  @override
  _ToggleButtonFormState createState() => _ToggleButtonFormState();
}

class _ToggleButtonFormState extends State<ToggleButtonForm> {
  bool _brktoggleButton1 = false;
  bool _lunchtoggleButton2 = false;
  bool _snacktoggleButton3 = false;
  bool _dnrtoggleButton4 = false;

  String _brkstatus1 = 'absent';
  String _lunchstatus2 = 'absent';
  String _snackstatus3 = 'absent';
  String _dnrstatus4 = 'absent';

  String _userName = ''; // Add a field for the user's name
  String _userId = ''; // Add a field for the user's ID
  DateTime? _lastAttendanceTime; // Add a field to store the last attendance time

  @override
  void initState() {
    super.initState();
    // Fetch user's name, ID, and last attendance time from 'users' collection when the widget initializes
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser!;

    DocumentSnapshot userSnapshot =
    await firestore.collection('users').doc(currentUser.email).get();

    setState(() {
      _userName = userSnapshot['Name'];
      _userId = userSnapshot['ID'] ?? '';
      _lastAttendanceTime = userSnapshot['lastAttendanceTime'] != null
          ? (userSnapshot['lastAttendanceTime'] as Timestamp).toDate()
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('BREAKFAST', style: GoogleFonts.actor(fontSize: 25)),
              Switch(
                value: _brktoggleButton1,
                onChanged: (bool value) {
                  setState(() {
                    _brktoggleButton1 = value;
                    _brkstatus1 = _brktoggleButton1 ? 'present' : 'absent';
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('LUNCH', style: GoogleFonts.actor(fontSize: 25)),
              Switch(
                value: _lunchtoggleButton2,
                onChanged: (bool value) {
                  setState(() {
                    _lunchtoggleButton2 = value;
                    _lunchstatus2 = _lunchtoggleButton2 ? 'present' : 'absent';
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SNACKS', style: GoogleFonts.actor(fontSize: 25)),
              Switch(
                value: _snacktoggleButton3,
                onChanged: (bool value) {
                  setState(() {
                    _snacktoggleButton3 = value;
                    _snackstatus3 = _snacktoggleButton3 ? 'present' : 'absent';
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DINNER', style: GoogleFonts.actor(fontSize: 25)),
              Switch(
                value: _dnrtoggleButton4,
                onChanged: (bool value) {
                  setState(() {
                    _dnrtoggleButton4 = value;
                    _dnrstatus4 = _dnrtoggleButton4 ? 'present' : 'absent';
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text('ID: $_userId', style: GoogleFonts.actor(fontSize: 20)),
        Text('Name: $_userName', style: GoogleFonts.actor(fontSize: 20)),
        ElevatedButton(
          onPressed: _isSubmitButtonDisabled() ? null : _storeToggleButtonDataInFirebase,
          child: Text('Submit'),
          style: ElevatedButton.styleFrom(
            primary: Colors.brown, // Change the button background color to brown
          ),
        ),

      ],
    );
  }

  Future<void> _storeToggleButtonDataInFirebase() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser!;

    // Format the current date and time
    String formattedDate = DateFormat('dd/MM').format(DateTime.now());
    String formattedTime = DateFormat('HH:mm').format(DateTime.now());

    // Check if a document with the same user ID already exists in 'attendance' collection
    QuerySnapshot<Map<String, dynamic>> existingAttendance = await firestore
        .collection('attendance')
        .where('ID', isEqualTo: _userId)
        .limit(1)
        .get();

    if (existingAttendance.docs.isNotEmpty) {
      // Update the existing document
      await firestore.collection('attendance').doc(_userId).update({
        'Name': _userName,
        'Breakfast': _brkstatus1,
        'Lunch': _lunchstatus2,
        'Snacks': _snackstatus3,
        'Dinner': _dnrstatus4,
        'date': formattedDate,
        'time': formattedTime,
      });
    } else {
      // Create a new document with user's ID as the document ID
      await firestore.collection('attendance').doc(_userId).set({
        'ID': _userId,
        'Name': _userName,
        'Breakfast': _brkstatus1,
        'Lunch': _lunchstatus2,
        'Snacks': _snackstatus3,
        'Dinner': _dnrstatus4,
        'date': formattedDate,
        'time': formattedTime,
      });
    }

    // Update the last attendance time in 'users' collection
    await firestore.collection('users').doc(currentUser.email).update({
      'lastAttendanceTime': FieldValue.serverTimestamp(),
    });

    // Refresh the user data after updating the last attendance time
    await _fetchUserData();

    // Show a success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submission Successful'),
          content: Text('Your attendance has been recorded successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _isSubmitButtonDisabled() {
    // Get the current time
    final currentTime = DateTime.now().toLocal();

    // Check if the current time is between 9 PM and 6 AM
    if (currentTime.hour >= 13 || currentTime.hour < 14) {
      // Enable the button if it's within the time frame
      return false;
    }

    // Disable the button if it's outside the time frame
    return true;
  }

}
