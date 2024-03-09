import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/components/mytextbox.dart';
import 'package:hostelbites/warden/wardenhome.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  //allusers
  final usersCollection = FirebaseFirestore.instance.collection("warden");

  //edit field
  Future<void> editfield(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.brown[200],
        title: Text(
          "Edit $field",
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Enter new $field",
              hintStyle: TextStyle(color: Colors.white54)
          ),
          onChanged: (value){
            newValue = value;
          },
        ),

        actions: [
          //cancel button
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: ()=>Navigator.pop(context),
          ),

          //save button
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: ()=>Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    //update in firestore
    if(newValue.trim().length>0){
      //only update if there is something in the textfield
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.brown,
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("warden")
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            //get user data
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  //profile pic
                  CircleAvatar(
                    radius: 72,
                    backgroundColor: Colors.brown,
                    child: Text(
                      userData['Name'] != null && userData['Name'].isNotEmpty
                          ? userData['Name'][0].toUpperCase()
                          : '',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //user email
                  Text(
                    currentUser.email!,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  //user details
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      'My Details',
                      // style: TextStyle(color: Colors.brown[400]),
                    ),
                  ),
                  //User Name
                  MyTextBox(
                    text: userData['Name'],
                    sectionName: 'N A M E',
                    onPressed: () => editfield('Name'),
                  ),

                  //Hostel Name
                  MyTextBox(
                    text: userData['Hostel'],
                    sectionName: 'H O S T E L',
                    onPressed: () => editfield('Hostel'),
                  ),

                  //Room No
                  MyTextBox(
                    text: userData['Phone'],
                    sectionName: 'P H O N E-N O',
                    onPressed: () => editfield('phone'),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
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
          selectedItemColor: Colors.grey.withOpacity(0.5),
          unselectedItemColor: Colors.brown[200],
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
              icon: Icon(
                Icons.person_rounded,
                size: 30,
              ),
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              // Navigate to the home screen (WardenHome) when "Home" icon is tapped
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WardenHome()),
              );
            }
          },
        ),
      ),
    );
  }
}
