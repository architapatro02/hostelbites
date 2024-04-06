import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
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
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notices available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var noticeData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var noticeText = noticeData['content'] ?? ''; // Replace 'yourTextFieldName'
              var noticetime = noticeData['timestamp'] ?? '';

              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    noticeText,
                    style: TextStyle(
                      color: Colors.blue, // Change the color here
                    ),
                  ),
                  subtitle: Text(
                    'Posted on: $noticetime',
                    style: TextStyle(
                      color: Colors.grey, // Change the color here
                    ),
                  ),
                  // Add other notice details as needed
                ),
              );
            },
          );
        },
      ),
    );
  }
}
