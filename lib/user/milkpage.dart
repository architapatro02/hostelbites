import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MilkDetailsPage extends StatefulWidget {
  @override
  _MilkDetailsPageState createState() => _MilkDetailsPageState();
}

class _MilkDetailsPageState extends State<MilkDetailsPage> {
  bool _subscribed = false;
  bool _buttonsEnabled = true;
  String _selectedMonth = 'January'; // Default month
  String _userId = '';
  final TextEditingController _userIdController = TextEditingController();

  void _subscribeToMilk() async {
    final CollectionReference milkCollection =
    FirebaseFirestore.instance.collection('milk');
    await milkCollection.add({
      'userId': _userId,
      'selectedMonth': _selectedMonth,
      'subscribed': true,
      'timestamp': FieldValue.serverTimestamp(),
    });
    setState(() {
      _subscribed = true;
      _buttonsEnabled = false;
      _userIdController.clear();
      // Enable both buttons after 30 days
      Future.delayed(Duration(days: 30), () {
        setState(() {
          _buttonsEnabled = true;
        });
      });
    });
  }

  void _unsubscribeFromMilk() async {
    final CollectionReference milkCollection =
    FirebaseFirestore.instance.collection('milk');
    await milkCollection.add({
      'userId': _userId,
      'selectedMonth': _selectedMonth,
      'subscribed': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
    setState(() {
      _subscribed = false;
      _buttonsEnabled = false;
      _userIdController.clear();
      // Enable both buttons after 30 days
      Future.delayed(Duration(days: 30), () {
        setState(() {
          _buttonsEnabled = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_drink),
            SizedBox(width: 10),
            Text('Milk Details')
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                fillColor: Colors.brown[300],
                filled: true,
                hintText: 'Student Id',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _userId = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          DropdownButton<String>(
            value: _selectedMonth,
            onChanged: _buttonsEnabled
                ? (String? newValue) {
              setState(() {
                _selectedMonth = newValue!;
              });
            }
                : null,
            style: TextStyle(color: Colors.brown[900]),
            items: <String>[
              'January',
              'February',
              'March',
              'April',
              'May',
              'June',
              'July',
              'August',
              'September',
              'October',
              'November',
              'December'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.brown[900]),
                ),
              );
            }).toList(),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _subscribed
                        ? 'You have subscribed for milk for $_selectedMonth with User ID: $_userId.'
                        : 'You have not subscribed for milk this month.',
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: _buttonsEnabled
                        ? () {
                      _subscribeToMilk();
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[300],
                    ),
                    child: Text(
                      'Yes, I want milk',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: _buttonsEnabled
                        ? () {
                      _unsubscribeFromMilk();
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[300],
                    ),
                    child: Text(
                      'No, I don\'t want milk',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
