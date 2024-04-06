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

              List<DataRow> rows = [];

              snapshot.data!.docs.forEach((doc) {
                String type = doc['type'];
                String feedback = doc['feedback'];
                String userName = doc['user_name'];
                String room = doc['user_room_no'];
                String timestamp = doc['timestamp']; // Timestamp field is of type String

                rows.add(buildDataRow(type, feedback, userName, room, timestamp));
              });

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                    DataColumn(
                      label: Text(
                        'Timestamp',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: rows,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(String type, String feedback, String userName, String room, String timestamp) {
    return DataRow(
      cells: [
        DataCell(buildText(type)),
        DataCell(buildText(feedback)),
        DataCell(buildText(userName)),
        DataCell(buildText(room)),
        DataCell(buildText(timestamp)),
      ],
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black87),
    );
  }
}
