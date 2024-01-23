import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/user/homeUser.dart';
import 'package:hostelbites/welcome/splash.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return checkuser();
  }

  checkuser()async{
    final user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      return UserHome();
    }
    else{
      return SplashScreen();
    }
  }
}

