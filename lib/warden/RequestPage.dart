import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Request'),
        centerTitle: true,
        backgroundColor: Colors.brown[700], // Darker brown shade
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown[400]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('registration_requests').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No registration requests available.'));
                  }

                  var totalRequests = snapshot.data!.docs.length;

                  return Text(
                    'Total Requests: $totalRequests',
                    style: GoogleFonts.actor(fontSize: 20, color: Colors.white54, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  );
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('registration_requests').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No registration requests available.'));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var requestData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                      var requestId = snapshot.data!.docs[index].id;
                      var studentName = requestData['Name'] ?? '';
                      var studentRoom = requestData['Room'] ?? '';
                      var studentDetails = '$studentName\n$studentRoom';

                      return AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          color: Colors.brown[100], // Lighter brown shade
                          child: ListTile(
                            title: Text(
                              studentDetails,
                              style: GoogleFonts.albertSans(fontSize: 20, color: Colors.black),
                            ),
                            onTap: () {
                              // Show detailed student information with a fade-in animation
                              showRegistrationRequestPopup(requestData, requestId);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void acceptRequest(String requestId, Map<String, dynamic> requestData) async {
    try {
      // Create a user with a default password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: requestData['Email'],
        password: requestData['Password'], // Default password
      );

      // Add student data to the users collection
      await FirebaseFirestore.instance.collection('users').doc(requestData['Email']).set({
        'Name': requestData['Name'],
        'ID': requestData['ID'],
        'Hostel': requestData['Hostel'],
        'Room': requestData['Room'],
        'Email': requestData['Email'],
      });

      // Remove the request from the registration_requests collection
      await FirebaseFirestore.instance.collection('registration_requests').doc(requestId).delete();

    } catch (e) {
      print('Error accepting request: $e');
      // Handle error
    }
  }

// Function to show a popup screen with detailed registration request information
  void showRegistrationRequestPopup(Map<String, dynamic> requestData, String requestId) {
    showDialog(
      context: context,
      builder: (context) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: 1.0,
          child: AlertDialog(
            title: Text(
              'Registration Request',
              style: GoogleFonts.actor(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.brown[300], // Medium brown shade
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${requestData['Name']}', style: GoogleFonts.acme(fontSize: 20, color: Colors.black)),
                  Text('ID: ${requestData['ID']}', style: GoogleFonts.acme(fontSize: 20, color: Colors.black)),
                  Text('Hostel: ${requestData['Hostel']}', style: GoogleFonts.acme(fontSize: 20, color: Colors.black)),
                  Text('Room: ${requestData['Room']}', style: GoogleFonts.acme(fontSize: 20, color: Colors.black)),
                  Text('Email: ${requestData['Email']}', style: GoogleFonts.acme(fontSize: 20, color: Colors.black)),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  acceptRequest(requestId, requestData);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // Set the text color to black
                ),
                child: Text('Accept'),
              ),
              TextButton(
                onPressed: () {
                  declineRequest(requestId);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // Set the text color to black
                ),
                child: Text('Decline'),
              ),
            ],
          ),
        );
      },
    );
  }
  // Function to decline a registration request
  void declineRequest(String requestId) async {
    try {
      // Remove the request from the registration_requests collection
      await FirebaseFirestore.instance.collection('registration_requests').doc(requestId).delete();
    } catch (e) {
      print('Error declining request: $e');
      // Handle error
    }
  }
}
