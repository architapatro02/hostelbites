import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowFeedbackPage extends StatefulWidget {
  @override
  _ShowFeedbackPageState createState() => _ShowFeedbackPageState();
}

class _ShowFeedbackPageState extends State<ShowFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[800],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.brown[900]),
        title: Text(
          'Feedback Details',
          style: TextStyle(
            color: Colors.brown[900],
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('feedback').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              List<Widget> rows = [];

              snapshot.data!.docs.forEach((doc) {
                String type = doc['type'] ?? 'Unknown';
                String feedback = doc['feedback'] ?? 'No feedback provided';
                String userName = doc['user_name'] ?? 'Anonymous';
                String room = doc['user_room_no'] ?? 'N/A';

                rows.add(buildDataRow(type, feedback, userName, room));
              });

              return ListView(
                children: rows,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildDataRow(String type, String feedback, String userName, String room) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: DataTable(
        columnSpacing: 20.0,
        headingRowHeight: 40.0,
        dataRowHeight: 60.0,
        horizontalMargin: 6.0,
        columns: [
          DataColumn(
            label: Text(
              'Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Feedback',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Room No',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(buildText(type)),
              DataCell(buildText(feedback)),
              DataCell(buildText(userName)),
              DataCell(buildText(room)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black87),
    );
  }
}
