import 'package:hostelbites/homeUser.dart';
import 'package:hostelbites/homeWarden.dart';
import 'package:hostelbites/loginWarden.dart';
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
      'homeUser': (context)=>const UserHome(),
      'loginWarden': (context)=>const MyLoginW(),
      'homeWarden':(context)=>const WardenHome()
    },
  )); //Material App
}
