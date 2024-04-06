
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hostelbites/welcome/splash.dart';
import 'package:flutter/material.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(  
      useMaterial3: false,
      primaryColor: Colors.purpleAccent
    ),
    initialRoute: 'splash',
    routes: {
      'splash': (context)=>const SplashScreen(),
    },
  ));//Material App
}
