import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/user/NavBar.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  // int myIndex=0;
  // List<Widget>widgetList=const [
  //   Text('Home', style: TextStyle(fontSize: 40)),
  //   Text('Menu', style: TextStyle(fontSize: 40)),
  //   Text('Profile', style: TextStyle(fontSize: 40))
  // ];

  signout()async{
    FirebaseAuth.instance.signOut().then((value){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      // body: Center(
      // ),
      appBar: AppBar(
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
