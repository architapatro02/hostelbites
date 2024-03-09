import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/warden/homeWarden.dart';
import 'package:hostelbites/warden/login_or_register_page_warden.dart';

class AuthPageW extends StatelessWidget {
  const AuthPageW({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return WardenHome();
          }
          else{
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}

