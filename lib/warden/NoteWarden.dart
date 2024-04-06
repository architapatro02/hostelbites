import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[800],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.brown[900]),
        title: Text('Notifications',
          style: TextStyle(
          color: Colors.brown[900],
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[300],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .orderBy('timestamp', descending: true) // Order by timestamp in descending order
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notifications available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var noteData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var studentId = noteData['ID'] ?? '';
              var studentName = noteData['Name'] ?? '';
              var noteText = noteData['Note'] ?? '';
              var noticeTime = noteData['timestamp'];

              // Check if noticeTime is already a Timestamp
              Timestamp timestamp;
              if (noticeTime is Timestamp) {
                timestamp = noticeTime;
              } else {
                // Handle if noticeTime is a string
                var parts = noticeTime.split(' '); // Split the string by space
                var timeParts = parts[0].split(':'); // Split the time part by colon
                var day = int.parse(parts[1]); // Parse the day
                var monthStr = parts[2]; // Extract the month string

                // Map month string to month number
                var monthMap = {
                  'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
                  'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
                };

                var month = monthMap[monthStr] ?? 1; // Get the month number or default to 1
                var hour = int.parse(timeParts[0]); // Parse the hour
                var minute = int.parse(timeParts[1]); // Parse the minute

                // Create DateTime object
                var postTime = DateTime(DateTime.now().year, month, day, hour, minute);
                timestamp = Timestamp.fromDate(postTime);
              }

              // Calculate the expiration time (24 hours from the post time)
              DateTime postTime = timestamp.toDate();
              DateTime expirationTime = postTime.add(Duration(hours: 24));

              // Check if the current time is past the expiration time
              bool isExpired = DateTime.now().isAfter(expirationTime);

              // Delete the feedback if it's expired
              if (isExpired) {
                FirebaseFirestore.instance
                    .collection('notes')
                    .doc(snapshot.data!.docs[index].id)
                    .delete();
              }

              return !isExpired
                  ? Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  leading: CircleAvatar(
                    backgroundColor: Colors.brown[300],
                    child: Text(
                      studentName[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    '$studentName ($studentId)',
                    style: TextStyle(
                      color: Colors.brown[900],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        noteText,
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      Text(
                        'Posted on: $postTime',
                        style: TextStyle(
                          color: Colors.grey, // Change the color here
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : SizedBox(); // Return an empty SizedBox if the feedback is expired
            },
          );
        },
      ),
    );
  }
}
