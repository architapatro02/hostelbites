import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/auth/forgotpassword.dart';
import 'package:hostelbites/components/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/components/mytextfield.dart';

class MyLogin extends StatefulWidget {
  final Function()? onTap;
  const MyLogin({super.key, required this.onTap});

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  //Text Editing controllor
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  //sign in method
  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //try sign in
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  //error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.brown[200],
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Icons
                Icon(
                  Icons.food_bank_outlined,
                  size: 100,
                ),
                //Welcome to Hostel Bites
                Text('Hostel Bites!!', style: GoogleFonts.montserrat(fontSize: 52)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome Student',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 50,
                ),
                //Enter your email
                MyTextField(
                    controller: emailcontroller,
                    hintText: 'Enter your Email',
                    obscureText: false),
                SizedBox(
                  height: 20,
                ),
                //Uihelper.CustomTextField(emailcontroller, 'Email', Icons.email_rounded, false),
                //Enter you password
                MyTextField(
                    controller: passcontroller,
                    hintText: 'Enter your Password',
                    obscureText: true),
                SizedBox(
                  height: 10,
                ),

                //Forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPass();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                //Login button
                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 15,
                ),

                //not registered yet?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not Registered yet?'),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
