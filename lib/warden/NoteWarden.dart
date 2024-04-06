import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
            .orderBy('timestamp', descending: true)
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

              Timestamp timestamp;
              if (noticeTime is Timestamp) {
                timestamp = noticeTime;
              } else {
                var parts = noticeTime.split(' ');
                var timeParts = parts[0].split(':');
                var day = int.parse(parts[1]);
                var monthStr = parts[2];

                var monthMap = {
                  'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
                  'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
                };

                var month = monthMap[monthStr] ?? 1;
                var hour = int.parse(timeParts[0]);
                var minute = int.parse(timeParts[1]);

                var postTime = DateTime(DateTime.now().year, month, day, hour, minute);
                timestamp = Timestamp.fromDate(postTime);
              }

              DateTime postTime = timestamp.toDate();
              DateTime expirationTime = postTime.add(Duration(hours: 24));
              bool isExpired = DateTime.now().isAfter(expirationTime);

              if (isExpired) {
                FirebaseFirestore.instance
                    .collection('notes')
                    .doc(snapshot.data!.docs[index].id)
                    .delete();
              }

              String formattedDateTime = DateFormat('HH:mm dd/MM/yyyy').format(postTime);

              return !isExpired
                  ? Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            color: Colors.black87
                        ),
                      ),
                      Text(
                        'Posted on: $formattedDateTime',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : SizedBox();
            },
          );
        },
      ),

    );
  }
}
