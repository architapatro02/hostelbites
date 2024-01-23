import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hostelbites/welcome/start.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>MyStart(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Center(child: Text('HOSTEL BITES', style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            fontFamily: 'FontMain'),
        )),
      ),
    );
  }
}
