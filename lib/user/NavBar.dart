import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostelbites/user/Attendance.dart';
import 'package:hostelbites/user/Feedback.dart';
import 'package:hostelbites/user/NoteStudent.dart';
import 'package:hostelbites/user/milkpage.dart';
import 'package:hostelbites/user/profile.dart';

class NavBar extends StatefulWidget {
  NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  signout() async {
    FirebaseAuth.instance.signOut().then((value) {});
  }

  final user = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Hello!!'),
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
                backgroundColor: Colors.brown[200],
                child: StreamBuilder<DocumentSnapshot>
                  (
                  stream: FirebaseFirestore.instance
                      .collection("users").doc(user.email).snapshots(),
                  builder: (context, snapshot){
                    //get user data
                    if(snapshot.hasData){
                      final userData = snapshot.data!.data() as Map<String, dynamic>;
                      return Text(
                        userData['Name'] != null && userData['Name'].isNotEmpty
                            ? userData['Name'][0].toUpperCase()
                            : '',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }else{
                      // Handle the case when data is not available
                      return Text(
                        '',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.brown[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.brown),
            title: Text('Mark Attendance'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MarkedAttendancePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_drink, color: Colors.brown),
            title: Text('Milk Details'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MilkDetailsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.note_alt, color: Colors.brown),
            title: Text('Special Note'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpecialNoteScreen(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.notifications, color: Colors.brown),
          //   title: Text('Notice'),
          //   onTap: ()  =>null,
          // ),
          ListTile(
            leading: Icon(Icons.feedback, color: Colors.brown),
            title: Text('Feedback'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.black,
          ),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app, color: Colors.brown),
            onTap: signout,
          ),
        ],
      ),
    );
  }
}
