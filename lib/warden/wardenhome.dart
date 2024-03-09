import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostelbites/warden/NoteWarden.dart';
import 'package:hostelbites/warden/go_premium.dart';
import 'package:hostelbites/warden/profile.dart';
import 'package:hostelbites/warden/tasks.dart'; // Import the NoticePage

class WardenHome extends StatefulWidget {
  const WardenHome({super.key});

  @override
  State<WardenHome> createState() => _WardenHomeState();
}

class _WardenHomeState extends State<WardenHome> {

  signout() async {
    FirebaseAuth.instance.signOut().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GoPremium(),
        Container(
          padding: EdgeInsets.all(25),
        ),

        Expanded(child: Tasks(),
        )
      ]),
        bottomNavigationBar: _buildBottomNavigationBar(context),


      floatingActionButton: FloatingActionButton(
        onPressed: signout,
        tooltip: 'Log OUT',
        child: const Icon(Icons.exit_to_app_sharp),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
Widget _buildBottomNavigationBar(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.brown.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 10,
        )
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.brown[200],
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home_rounded,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: GestureDetector(
              onTap: () {
                // Handle navigation to the profile page here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()), // Replace ProfilePage with your actual profile page widget
                );
              },
              child: Icon(
                Icons.person_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
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



