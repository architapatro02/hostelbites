import 'package:flutter/material.dart';
import 'package:hostelbites/warden/signupWarden.dart';
import 'package:hostelbites/warden/loginWarden.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
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
