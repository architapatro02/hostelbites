import 'package:flutter/material.dart';
import 'package:hostelbites/user/loginUser.dart';
import 'package:hostelbites/user/signupUser.dart';

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
      return MyLogin(
          onTap: togglePages
      );
    } else {
      return MyRegisterPage(
        onTap: togglePages,
      );
    }
  }
}
