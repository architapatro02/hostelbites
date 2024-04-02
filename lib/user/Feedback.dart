import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/components/mybutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _textController = TextEditingController();
  String? _selectedType;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
            Icon(Icons.feedback),
            SizedBox(width: 2),
            Text('Feedback'),
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
                  'Student Feedback !!',
                  style: GoogleFonts.actor(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

              ),
            ),

          ),
          SizedBox(height: 20),
          Center(
            child: DropdownButton<String>(
              value: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
              items: const [
                DropdownMenuItem(
                  child: Text('Select an option'),
                  value: null,
                ),
                DropdownMenuItem(
                  child: Text('Breakfast'),
                  value: 'breakfast',
                ),
                DropdownMenuItem(
                  child: Text('Lunch'),
                  value: 'lunch',
                ),
                DropdownMenuItem(
                  child: Text('Snacks'),
                  value: 'snacks',
                ),
                DropdownMenuItem(
                  child: Text('Dinner'),
                  value: 'dinner',
                ),
              ],
            ),
          ),
          if (_selectedType != null) ...[
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Enter your feedback here',
                ),
              ),
            ),
            const SizedBox(height: 20),
            MyButton(
              onTap: () {
                if (_textController.text.trim().isEmpty) {
                  // Show an error message if feedback text is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter your feedback before submitting.'),
                    ),
                  );
                } else {
                  _submitFeedback();
                }
              },
              text: 'Submit',
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _submitFeedback() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final String userEmail = user.email ?? ''; // User's email

        // Retrieve user details from 'users' collection
        QuerySnapshot userQuerySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('Email', isEqualTo: userEmail)
            .get();

        if (userQuerySnapshot.docs.isNotEmpty) {
          // Get the first document from the query result
          DocumentSnapshot userSnapshot = userQuerySnapshot.docs.first;

          final String userId = userSnapshot.id.toString(); // User's document ID in the 'users' collection
          final String userName = userSnapshot['Name'] ?? ''; // Provide a default value if the field is missing
          final String userRoomNo = userSnapshot['Room'] ?? ''; // Provide a default value if the field is missing

          // Store feedback in Firestore with a timestamp
          await FirebaseFirestore.instance.collection('feedback').add({
            'type': _selectedType,
            'feedback': _textController.text,
            'user_email': userEmail,
            'user_name': userName,
            'user_room_no': userRoomNo,
            'user_id': userId, // Include the user's ID from the 'users' collection
            'timestamp': FieldValue.serverTimestamp(),
          });

          // Reset form
          _textController.clear();
          setState(() {
            _selectedType = null;
          });

          // Show success message or navigate to another screen
          // You can customize this based on your requirements
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Feedback submitted successfully!'),
            ),
          );
        } else {
          // Handle case where no user details are found
          print('No user details found in the "users" collection. User email: $userEmail');
        }
      }
    } catch (e) {
      // Handle errors
      print('Error submitting feedback: $e');
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting feedback. Please try again.'),
        ),
      );
    }
  }

  // Function to periodically delete old feedback entries
  void _scheduleFeedbackCleanup() {
    // Use a periodic timer to run a cleanup task every 24 hours
    const cleanupInterval = Duration(hours: 24);
    Timer.periodic(cleanupInterval, (Timer timer) {
      _deleteOldFeedbackEntries();
    });
  }

  // Function to delete feedback entries older than 24 hours
  Future<void> _deleteOldFeedbackEntries() async {
    try {
      final DateTime now = DateTime.now();
      final DateTime cutoffTime = now.subtract(Duration(hours: 24));

      QuerySnapshot oldFeedbackSnapshot = await FirebaseFirestore.instance
          .collection('feedback')
          .where('timestamp', isLessThan: Timestamp.fromDate(cutoffTime))
          .get();

      if (oldFeedbackSnapshot.docs.isNotEmpty) {
        // Delete each old feedback entry
        for (DocumentSnapshot feedbackDoc in oldFeedbackSnapshot.docs) {
          await feedbackDoc.reference.delete();
        }
      }
    } catch (e) {
      print('Error deleting old feedback entries: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Schedule the feedback cleanup task when the widget is first created
    _scheduleFeedbackCleanup();
  }
}
