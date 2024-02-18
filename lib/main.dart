import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hostelbites/auth/checkUser.dart';
import 'package:hostelbites/user/homeUser.dart';
import 'package:hostelbites/warden/homeWarden.dart';
import 'package:hostelbites/warden/loginWarden.dart';
import 'package:hostelbites/welcome/splash.dart';
import 'package:hostelbites/user/loginUser.dart';
import 'package:hostelbites/user/signupUser.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/welcome/start.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.purpleAccent
    ),
    initialRoute: 'splash',
    routes: {
      'splash': (context)=>const SplashScreen(),
    },
  ));//Material App
}


