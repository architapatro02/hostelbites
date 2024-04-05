// profile.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/components/mytextbox.dart';
import 'package:hostelbites/warden/commonBottomNavigation.dart';
import 'package:hostelbites/warden/wardenhome.dart';
import 'package:hostelbites/warden/inventorypage.dart'; // Import the InventoryPage

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 2; // Default index for ProfileScreen

  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("warden");

  signout() async {
    FirebaseAuth.instance.signOut().then((value) {});
  }

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.brown[200],
        title: Text(
          "Edit $field",
          style: GoogleFonts.adamina(
              // Example font from Google Fonts, you can replace it with any other font
              fontSize: 20,
              color: Colors.black // Adjust the font size as needed
              ),
        ),
        content: TextField(
          autofocus: true,
          style: GoogleFonts.alata(
            fontSize: 20, // Adjust the font size as needed
          ),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.white54),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.alef(
                  // Example font from Google Fonts, you can replace it with any other font
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold // Adjust the font size as needed
                  ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              'Save',
              style: GoogleFonts.alef(
                // Example font from Google Fonts, you can replace it with any other font
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold // Adjust the font size as needed
              ),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    if (newValue.trim().length > 0) {
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
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 72,
                  backgroundColor: Colors.brown,
                  child: Text(
                    userData['Name'] != null && userData['Name'].isNotEmpty
                        ? userData['Name'][0].toUpperCase()
                        : '',
                    style: GoogleFonts.actor(
                      // Example font from Google Fonts, you can replace it with any other font
                        fontSize: 50,
                        color: Colors.white // Adjust the font size as needed
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.albertSans(
                    // Example font from Google Fonts, you can replace it with any other font
                    fontSize: 16, // Adjust the font size as needed
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My Details',
                    style: GoogleFonts.alef(
                        fontSize: 15,
                        color: Colors.black // Adjust the font size as needed
                    ),
                  ),
                ),
                MyTextBox(
                  text: userData['Name'],
                  sectionName: 'N A M E',
                  onPressed: () => editField('Name'),
                ),
                MyTextBox(
                  text: userData['Hostel'],
                  sectionName: 'H O S T E L',
                  onPressed: () => editField('Hostel'),
                ),
                MyTextBox(
                  text: userData['Phone'],
                  sectionName: 'P H O N E-N O',
                  onPressed: () => editField('phone'),
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
      bottomNavigationBar: CommonBottomNavigationBar(
        onTabTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (_currentIndex) {
            case 0:
              // Handle Home page navigation
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WardenHome()),
              );
              break;
            case 1:
              // Current page, no action needed
              // Handle Inventory page navigation
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => InventoryPage()),
              );
              break;
            case 2:
              break;
            default:
              break;
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
}
