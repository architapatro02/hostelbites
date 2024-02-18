import 'package:flutter/material.dart';
import 'package:hostelbites/user/Attendance.dart';
import 'package:hostelbites/user/Note.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Khushi'),
            accountEmail: Text('khushi172004@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/images/profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.brown[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu,color: Colors.brown),
            title: Text('View Menu'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person,color: Colors.brown),
            title: Text('Mark Attendance'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context)=> MarkedAttendancePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_drink,color: Colors.brown),
            title: Text('Milk Details'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.note_alt,color: Colors.brown),
            title: Text('Special Note'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=> SpecialNoteScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications,color: Colors.brown),
            title: Text('Notice'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.feedback,color: Colors.brown),
            title: Text('Feedback'),
            onTap: () => null,
          ),
          Divider(
            height: 10.0,
            color: Colors.black,
          ),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app,color: Colors.brown),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
