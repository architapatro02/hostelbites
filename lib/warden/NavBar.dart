import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:hostelbites/user/Attendance.dart';
// import 'package:hostelbites/user/Feedback.dart';
// import 'package:hostelbites/user/milkpage.dart';
 import 'package:hostelbites/warden/profile.dart';
import 'package:hostelbites/warden/EditMenu.dart';
import 'package:hostelbites/warden/Notice.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final user=FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Hello Jiji!!'),
            accountEmail: Text(user.email!),
            currentAccountPicture: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              child: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.brown[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts, color: Colors.brown),
            title: Text('Manage Students'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MenuPage(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu, color: Colors.brown),
            title: Text('Edit Menu'),
            onTap: ()  {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=> EditMenu(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_drink, color: Colors.brown),
            title: Text('Milk Details'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MarkedAttendancePage(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.brown),
            title: Text('View Attendance'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MilkDetailsPage(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.note_alt, color: Colors.brown),
            title: Text('Important Note'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpecialNoteScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback, color: Colors.brown),
            title: Text('Feedback'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FeedbackScreen(),
              //   ),
              // );
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.black,
          ),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app, color: Colors.brown),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
