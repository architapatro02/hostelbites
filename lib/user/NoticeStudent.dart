import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.brown[300],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notice').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.black)));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notices available.', style: TextStyle(color: Colors.black)));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var noticeData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var noticeText = noticeData['content'] ?? '';
              var noticeTime = noticeData['timestamp'];

              String formattedDateTime = _formatTimestamp(noticeTime);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      noticeText,
                      style: TextStyle(color: Colors.brown[900], fontSize: 18),
                    ),
                    subtitle: Text(
                      'Posted on: $formattedDateTime',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return DateFormat('HH:mm dd/MM/yyyy').format(timestamp.toDate());
    } else if (timestamp is String) {
      // Parse string timestamp
      // Implement parsing logic based on your timestamp format
      return timestamp;
    } else {
      return '';
    }
  }
}
