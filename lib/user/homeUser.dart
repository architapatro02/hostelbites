import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/user/loginUser.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int myIndex=0;
  List<Widget>widgetList=const [
    Text('Home', style: TextStyle(fontSize: 40)),
    Text('Menu', style: TextStyle(fontSize: 40)),
    Text('Profile', style: TextStyle(fontSize: 40))
  ];

  signout()async{
    FirebaseAuth.instance.signOut().then((value){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetList[myIndex],
      ),
      // body: IndexedStack(
      //   index: myIndex,
      //   children: widgetList,
      // ),
      appBar: AppBar(
        title: const Text('Home page'),
        centerTitle: true,
        backgroundColor: Colors.brown[300],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            myIndex=index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.brown),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Menu',
              backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Profile',
              backgroundColor: Colors.amber
          ),
        ],),
      floatingActionButton: FloatingActionButton(
        onPressed: signout,
        tooltip: 'Log OUT',
        child: const Icon(Icons.logout_outlined),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
