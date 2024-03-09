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
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        title: Text('Feedback Details'),
        centerTitle: true,
        backgroundColor: Colors.brown[500],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.brown[300],
              // width: screenWidth * 0.9,
              child: Card(
                elevation: 5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder<QuerySnapshot>(
                    future:
                        FirebaseFirestore.instance.collection('feedback').get(),
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
                        // Timestamp timestamp = doc['timestamp'];

                        rows.add(DataRow(
                          cells: [
                            DataCell(Text(type)),
                            DataCell(Text(feedback)),
                            DataCell(Text(userName)),
                            DataCell(Text(room)),
                            // DataCell(Text(timestamp.toDate().toString())),
                          ],
                        ));
                      });

                      return DataTable(
                        columnSpacing: 20.0,
                        headingRowHeight: 40.0,
                        dataRowHeight: 60.0,
                        horizontalMargin: 10.0,
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
                          // DataColumn(
                          //   label: Text(
                          //     'Timestamp',
                          //     style: TextStyle(fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                        ],
                        rows: rows,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
