import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostelbites/warden/NavBar.dart';
import 'package:hostelbites/warden/NoteWarden.dart'; // Import the NoticePage

class WardenHome extends StatefulWidget {
  const WardenHome({super.key});

  @override
  State<WardenHome> createState() => _WardenHomeState();
}

class _WardenHomeState extends State<WardenHome> {
  // Function to navigate to the NoticePage
  // void _navigateToNoticePage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => NotePage()),
  //   );
  // }

  signout() async {
    FirebaseAuth.instance.signOut().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to the notifications page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotePage()),
              );
            },
          ),
        ],
        title: const Text('Home page'),
        centerTitle: true,
        backgroundColor: Colors.brown[300],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: signout,
        tooltip: 'Log OUT',
        child: const Icon(Icons.exit_to_app_sharp),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
