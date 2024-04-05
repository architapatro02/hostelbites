import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MilkDetailsPage extends StatefulWidget {
  @override
  _MilkDetailsPageState createState() => _MilkDetailsPageState();
}

class _MilkDetailsPageState extends State<MilkDetailsPage> {
  bool _subscribed = false;
  bool _buttonsEnabled = true;
  String _selectedMonth = DateFormat('MMMM').format(DateTime.now()); // Default month
  String _userId = '';
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _checkButtonAvailability();
  }

  void _fetchUserData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser!;

    DocumentSnapshot userSnapshot =
    await firestore.collection('users').doc(currentUser.email).get();

    setState(() {
      _userName = userSnapshot['Name'];
      _userId = userSnapshot['ID'] ?? '';
      _subscribed = false;
    });
  }

  void _checkButtonAvailability() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastInteractionTimestamp = prefs.getInt('lastInteractionTimestamp') ?? 0;

    DateTime now = DateTime.now();
    DateTime lastInteractionDate =
    DateTime.fromMillisecondsSinceEpoch(lastInteractionTimestamp);
    DateTime nextInteractionDate =
    lastInteractionDate.add(Duration(days: 28));

    if (now.isAfter(nextInteractionDate)) {
      setState(() {
        _buttonsEnabled = true;
      });
    } else {
      setState(() {
        _buttonsEnabled = false;
      });
    }
  }

  void _updateSubscription(bool subscribe) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference milkCollection = firestore.collection('milk');

    try {
      await milkCollection.doc(_userId).set({
        'userName': _userName,
        'userId': _userId,
        'selectedMonth': _selectedMonth,
        'subscribed': subscribe,
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _subscribed = subscribe;
        _buttonsEnabled = false;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('lastInteractionTimestamp', DateTime.now().millisecondsSinceEpoch);

      // Enable buttons after 28 days
      Future.delayed(Duration(days: 28), () {
        if (mounted) {
          setState(() {
            _buttonsEnabled = true;
          });
        }
      });
    } catch (error) {
      print('Error updating subscription: $error');
    }
  }

  Widget _buildHeader() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.brown[900],
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(
              'assets/images/milkk.jpg'), // Replace 'assets/background_image.jpg' with your image asset path
          fit: BoxFit.cover,
        ),
      ),
    );
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _subscribed
                    ? 'You have subscribed for milk for $_selectedMonth with User ID: $_userId and Username: $_userName.'
                    : 'You have not subscribed for milk this month.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _buttonsEnabled
                    ? () => _updateSubscription(true) // Subscribe to milk
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[300],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Yes, I want milk',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _buttonsEnabled
                    ? () => _updateSubscription(false) // Unsubscribe from milk
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[300],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'No, I don\'t want milk',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (!_buttonsEnabled)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 50,
                  child: Marquee(
                    text:
                    'Both buttons will be enabled after 28 days.',
                    velocity: 30,
                    blankSpace: 20,
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 10,
                    fadingEdgeStartFraction: 0.1,
                    fadingEdgeEndFraction: 0.1,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
