import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/mybutton.dart';
import '../components/mytextfield.dart';

class MyRegisterPageW extends StatefulWidget {
  final Function()? onTap;
  const MyRegisterPageW({super.key, required this.onTap});
  @override
  State<MyRegisterPageW> createState() => _MyRegisterPageWState();
}

class _MyRegisterPageWState extends State<MyRegisterPageW> {
  //Text Editing controllor
  TextEditingController namecontroller = TextEditingController();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController hostelcontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();

  //sign in method
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //check if pass=confirm pass
    if (passwordConfirmed()) {
      //create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);

      //add user details
      addUserDetails(
        namecontroller.text.trim(),
        idcontroller.text.trim(),
        hostelcontroller.text.trim(),
        int.parse(roomcontroller.text.trim()),
        emailcontroller.text.trim(),
      );
      Navigator.pop(context);
    }
    Navigator.pop(context);
  }

  //add user details
  void addUserDetails(
      String name, String studID, String hostel, int room, String email) async {
    await FirebaseFirestore.instance.collection('warden').add({
      'Name': name,
      'Student_Id': studID,
      'Hostel': hostel,
      'Room': room,
      'Email': email,
    });
  }

  //password = confirm passowrd
  bool passwordConfirmed() {
    if (passcontroller.text.trim() == confirmpasscontroller.text.trim()) {
      return true;
    } else {
      return false;
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
                // Icon(
                //   Icons.food_bank_outlined,
                //   size: 100,
                // ),
                //Welcome to Hostel Bites
                Text('Annyeong!!',
                    style: GoogleFonts.montserrat(
                      fontSize: 52,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Let\'s create an account for you!!',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),

                //Enter your Name
                MyTextField(
                    controller: namecontroller,
                    hintText: 'Enter your Name',
                    obscureText: false),
                SizedBox(
                  height: 5,
                ),

                //Enter your ID
                MyTextField(
                    controller: idcontroller,
                    hintText: 'Enter your Student ID',
                    obscureText: false),
                SizedBox(
                  height: 5,
                ),
                MyTextField(
                    controller: hostelcontroller,
                    hintText: 'Enter your Hostel name',
                    obscureText: false),

                SizedBox(
                  height: 5,
                ),
                //Enter your Room No
                MyTextField(
                    controller: roomcontroller,
                    hintText: 'Enter your Room No',
                    obscureText: false),
                const SizedBox(
                  height: 5,
                ),

                //Enter your email
                MyTextField(
                    controller: emailcontroller,
                    hintText: 'Enter your Email',
                    obscureText: false),
                SizedBox(
                  height: 5,
                ),

                //Enter you password
                MyTextField(
                    controller: passcontroller,
                    hintText: 'Enter your Password',
                    obscureText: true),
                SizedBox(
                  height: 5,
                ),

                //Confirm your password
                MyTextField(
                    controller: confirmpasscontroller,
                    hintText: 'Confirm your Password',
                    obscureText: true),
                SizedBox(
                  height: 15,
                ),

                //SignUp button
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),
                SizedBox(
                  height: 10,
                ),

                // //or continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.brown[250],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text(
                //           "or continue with",
                //           style: TextStyle(color: Colors.black),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.brown[250],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                //
                // SizedBox(
                //   height: 10,
                // ),
                //
                // //google sign in
                // GestureDetector(
                //   onTap: AuthService().signInWithGoogle,
                //   child: Image.asset(
                //     'assets/images/googlelogo.jpg',
                //     height: 50,
                //   ),
                // ),
                // SizedBox(
                //   height: 15,
                // ),

                //not registered yet?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already a member?'),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login Now',
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
