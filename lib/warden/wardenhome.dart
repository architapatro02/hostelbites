// wardenHome.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostelbites/warden/InventoryPage.dart';
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

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[800],
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
          switch (_currentIndex) {
            case 0:
            // Home Page
            // You can add navigation logic or replace the current page
              break;
            case 1:
            // Profile Page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => InventoryPage()),
              );
              break;
            case 2:
            // Inventory Page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              break;
            default:
              break;
          }
        },
        currentIndex: _currentIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: signOut,
        tooltip: 'Log OUT',
        child: const Icon(Icons.exit_to_app_sharp),
        backgroundColor: Colors.brown,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.brown[900]),
      centerTitle: true,
      backgroundColor: Colors.brown[200],
      elevation: 0,
      title: Row(
        children: [
          SizedBox(width: 10),
          Text(
            ' " Welcome Jiji " ',
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
