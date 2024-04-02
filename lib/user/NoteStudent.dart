import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialNoteScreen extends StatefulWidget {
  const SpecialNoteScreen({Key? key}) : super(key: key);

  @override
  State<SpecialNoteScreen> createState() => _SpecialNoteScreenState();
}

class _SpecialNoteScreenState extends State<SpecialNoteScreen> {
  final _textController = TextEditingController();
  String userPost = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
            Icon(Icons.account_balance_wallet),
            SizedBox(width: 2),
            Text('Notice'),
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
                  'Special Note For Warden !!',
                  style: GoogleFonts.actor(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

              ),
            ),

          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'What\'s on your mind?',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textController.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                MaterialButton(
                  onPressed: () async {
                    await postSpecialNote();
                  },
                  color: Colors.brown,
                  child: const Text('Post'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> postSpecialNote() async {
    try {
      // Get current user information
      final User? user = _auth.currentUser;
      final String userEmail = user?.email ?? '';

      // Fetch user document from the "users" collection based on the email
      DocumentSnapshot userSnapshot =
      await _firestore.collection('users').doc(userEmail).get();

      // Check if the user document exists
      if (userSnapshot.exists) {
        final String studentId = userSnapshot['ID'] ?? '';
        final String studentName = userSnapshot['Name'] ?? '';

        // Get special note from the text field
        userPost = _textController.text;

        // Check if the note is not empty
        if (userPost.isNotEmpty) {
          // Store the special note in the "notes" collection with formatted timestamp
          await _firestore.collection('notes').add({
            'ID': studentId,
            'Note': userPost,
            'Name': studentName,
            'timestamp': formattedTimestamp(),
          });

          // Show a success dialog and clear the text field
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Success'),
              content: Text('Special note posted successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _textController.clear();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          // Show an error dialog if the note is empty
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('Please enter a special note before posting.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        // Show an error dialog if the user document does not exist
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('User information not found.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle the error
      print('Error posting special note: $e');
    }
  }

  String formattedTimestamp() {
    // Format the timestamp as 'hh:mm dd MMM'
    DateTime now = DateTime.now();
    String monthName = getMonthName(now.month);
    String formattedDate = "${now.hour}:${now.minute} ${now.day} $monthName";
    return formattedDate;
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

}
