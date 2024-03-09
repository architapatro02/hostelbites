import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/components/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/components/mytextfield.dart';

class MyRegisterPage extends StatefulWidget {
  final Function()? onTap;
  const MyRegisterPage({super.key, required this.onTap});

  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
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
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Check if pass = confirm pass
    if (passcontroller.text != confirmpasscontroller.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords don't match");
      return;
    }

    // Try creating the user
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passcontroller.text,
      );

      // After creating user, set specific document ID for the user in 'users' collection
      String? userId = userCredential.user!.email; // Get the UID
      DocumentReference userDocRef =
      FirebaseFirestore.instance.collection("users").doc(userId);

      // Check if the 'users' collection already has a document with the user ID
      if (!(await userDocRef.get()).exists) {
        // If not, create the document
        await userDocRef.set({
          'Name': namecontroller.text,
          'ID': idcontroller.text,
          'Hostel': hostelcontroller.text,
          'Room': roomcontroller.text,
          'Email': emailcontroller.text,
        });
      }

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop the loading circle
      Navigator.pop(context);
      // Show error message
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
                SizedBox(
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
