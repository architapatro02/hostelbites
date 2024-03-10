import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/warden/wardenhome.dart';
import 'package:hostelbites/warden/login_or_register_page_warden.dart';

class AuthPageW extends StatelessWidget {
  final String userType;

  AuthPageW({required this.userType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = snapshot.data;

            // Check if the user exists in the "warden" collection
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('warden').doc(user?.email).get(),
              builder: (context, wardenSnapshot) {
                if (wardenSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while checking
                }

                if (wardenSnapshot.hasError) {
                  return Text('Error: ${wardenSnapshot.error}');
                }

                if (wardenSnapshot.hasData && wardenSnapshot.data!.exists) {
                  // User exists in the "warden" collection, navigate to WardenHome
                  return WardenHome();
                } else {
                  // User doesn't exist in the "warden" collection, show login/register page for wardens
                  return LoginOrRegisterPageW();
                }
              },
            );
          } else {
            // If there's no user data, show the login/register page for wardens
            return LoginOrRegisterPageW();
          }
        },
      ),
    );
  }
}
