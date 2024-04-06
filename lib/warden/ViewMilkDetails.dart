import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewMilkDetails extends StatefulWidget {
  @override
  _ViewMilkDetailsState createState() => _ViewMilkDetailsState();
}

class _ViewMilkDetailsState extends State<ViewMilkDetails> {
  String _filterBy = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.brown[900]),
        title: Text('View Milk Details',
          style: TextStyle(
            color: Colors.brown[900],
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown[500], // Use similar color to MilkDetailsPage
      ),
      backgroundColor: Colors.brown[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            color: Colors.transparent, // Background color for the dropdown area
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  value: _filterBy,
                  icon: Icon(Icons.filter_alt),
                  onChanged: (String? newValue) {
                    setState(() {
                      _filterBy = newValue!;
                    });
                  },
                  items: <String>['All', 'Subscribed', 'Unsubscribed']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
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

                var filteredDocs = snapshot.data!.docs;
                if (_filterBy != 'All') {
                  filteredDocs = snapshot.data!.docs
                      .where((doc) => doc['subscribed'] == (_filterBy == 'Subscribed'))
                      .toList();
                }

                return ListView(
                  children: filteredDocs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(
                        'User ID: ${data['userId']}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      subtitle: Text(
                        'Month: ${data['selectedMonth']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      trailing: Text(
                        data['subscribed'] ? 'Subscribed' : 'Unsubscribed',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: data['subscribed'] ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
