import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewMilkDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Milk Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('milk').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text('User ID: ${data['userId']}'),
                subtitle: Text('Month: ${data['selectedMonth']}'),
                trailing: Text(data['subscribed'] ? 'Subscribed' : 'Unsubscribed'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
