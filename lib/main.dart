import 'package:hostelbites/home1.dart';
import 'package:hostelbites/splash.dart';
import 'package:hostelbites/login.dart';
import 'package:hostelbites/register.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splash',
    routes: {
      'splash': (context)=>const SplashScreen(),
      'login': (context)=>const MyLogin(),
      'register': (context)=>const MyRegister(),
      'home1': (context)=>const UserHome()
    },
  )); //Material App
}
