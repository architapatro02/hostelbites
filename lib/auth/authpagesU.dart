import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/user/homeUser.dart';
import 'package:hostelbites/user/login_or_register_page_user.dart';

class AuthPage extends StatelessWidget {
  final String userType;

  AuthPage({required this.userType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = snapshot.data;

            // Check if the user exists in the "users" collection
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(user?.email).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while checking
                }

                if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                }

                if (userSnapshot.hasData && userSnapshot.data!.exists) {
                  // User exists in the "users" collection, navigate to UserHome
                  return UserHome();
                } else {
                  // User doesn't exist in the "users" collection, show login/register page for students
                  return LoginOrRegisterPage();
                }
              },
            );
          } else {
            // If there's no user data, show the login/register page for students
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
