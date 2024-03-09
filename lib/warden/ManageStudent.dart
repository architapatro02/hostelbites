import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageStudentsPage extends StatefulWidget {
  const ManageStudentsPage({Key? key}) : super(key: key);

  @override
  _ManageStudentsPageState createState() => _ManageStudentsPageState();
}

class _ManageStudentsPageState extends State<ManageStudentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Students'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown[200]!, Colors.brown[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No student data available.'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var studentData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                var studentId = studentData['ID'] ?? '';
                var studentName = studentData['Name'] ?? '';
                var studentRoom = studentData['Room'] ?? '';
                var studentDetails = '$studentName\n$studentRoom';

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.white70, // Card background color
                  child: ListTile(
                    title: Text(
                      studentDetails,
                      style: GoogleFonts.merriweather(fontSize: 18),
                      // style: TextStyle(
                      //   color: Colors.black,
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                    onTap: () {
                      // Show detailed student information in a popup screen
                      showStudentDetailsPopup(studentData);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Function to show a popup screen with detailed student information
  void showStudentDetailsPopup(Map<String, dynamic> studentData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Student Details'),
          backgroundColor: Colors.brown[200], // Set background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${studentData['Name']}'),
                Text('ID: ${studentData['ID']}'),
                Text('Hostel: ${studentData['Hostel']}'),
                Text('Room: ${studentData['Room']}'),
                Text('Email: ${studentData['Email']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
