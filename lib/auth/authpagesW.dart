import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/user/homeUser.dart';
import 'package:hostelbites/user/loginUser.dart';
import 'package:hostelbites/user/login_or_register_page.dart';

class AuthPageW extends StatelessWidget {
  const AuthPageW({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return UserHome();
          }
          else{
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}

