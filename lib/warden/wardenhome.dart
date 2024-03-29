// wardenHome.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostelbites/warden/NoteWarden.dart';
import 'package:hostelbites/warden/commonBottomNavigation.dart';
import 'package:hostelbites/warden/go_premium.dart';
import 'package:hostelbites/warden/profile.dart';
import 'package:hostelbites/warden/tasks.dart'; // Import the common bottom navigation bar

class WardenHome extends StatefulWidget {
  const WardenHome({Key? key}) : super(key: key);

  @override
  State<WardenHome> createState() => _WardenHomeState();
}

class _WardenHomeState extends State<WardenHome> {
  int _currentIndex = 0;

  signout() async {
    FirebaseAuth.instance.signOut().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GoPremium(),
          Container(
            padding: EdgeInsets.all(25),
          ),
          Expanded(
            child: Tasks(),
          ),
        ],
      ),
      bottomNavigationBar: CommonBottomNavigationBar(
        onTabTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (_currentIndex == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
        },
        currentIndex: _currentIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: signout,
        tooltip: 'Log OUT',
        child: const Icon(Icons.exit_to_app_sharp),
        backgroundColor: Colors.brown,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/dp.jpg'),
              radius: 30,
            ),
          ),
          SizedBox(width: 10),
          Text(
            'Welcome Jiji',
            style: TextStyle(
              color: Colors.brown[900],
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotePage(),
              ),
            );
          },
          icon: Icon(Icons.notifications),
          color: Colors.brown[900],
        ),
      ],
    );
  }
}
