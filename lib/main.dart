import 'package:hostelbites/homeUser.dart';
import 'package:hostelbites/splash.dart';
import 'package:hostelbites/loginUser.dart';
import 'package:hostelbites/registerUser.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/start.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'start',
    routes: {
      'splash': (context)=>const SplashScreen(),
      'start': (context)=>const MyStart(),
      'loginUser': (context)=>const MyLogin(),
      'registerUser': (context)=>const MyRegister(),
      'home1': (context)=>const UserHome(),
    },
  )); //Material App
}
