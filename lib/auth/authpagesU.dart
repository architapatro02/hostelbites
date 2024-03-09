import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/user/homeUser.dart';
import 'package:hostelbites/user/login_or_register_page_user.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot2){
          if(snapshot2.hasData){
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

