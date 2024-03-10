import 'package:flutter/material.dart';
import 'package:hostelbites/warden/signupWarden.dart';
import 'package:hostelbites/warden/loginWarden.dart';

class LoginOrRegisterPageW extends StatefulWidget {
  const LoginOrRegisterPageW({super.key});

  @override
  State<LoginOrRegisterPageW> createState() => _LoginOrRegisterPageWState();
}

class _LoginOrRegisterPageWState extends State<LoginOrRegisterPageW> {
  //initially show login page
  bool showLoginPage = true;

  //toggle between login or register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return MyLoginW(
          onTap: togglePages
      );
    } else {
      return MyRegisterPageW(
        onTap: togglePages,
      );
    }
  }
}
