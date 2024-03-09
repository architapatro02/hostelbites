import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/components/mybutton.dart';

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
          padding: const EdgeInsets.symmetric(horizontal:25.0),
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

        MyButton(
            onTap: () {
              _storeToggleButtonDataInFirebase();
            },
            text: 'Submit')
      ],
    );
  }

  Future<void> _storeToggleButtonDataInFirebase() async {
    // Get a reference to the Firestore database
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Store the data in the 'toggleButtonData' collection
    await firestore.collection('toggleButtonData').add({
      'Breakfast': _brkstatus1,
      'Lunch': _lunchstatus2,
      'Snacks': _snackstatus3,
      'Dinner': _dnrstatus4,
      'timestamp': Timestamp.now(),
    });
  }
}
