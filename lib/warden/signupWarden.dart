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
  TextEditingController phonecontroller = TextEditingController();
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
      FirebaseFirestore.instance.collection("warden").doc(userId);

      // Check if the 'users' collection already has a document with the user ID
      if (!(await userDocRef.get()).exists) {
        // If not, create the document
        await userDocRef.set({
          'Name': namecontroller.text,
          'Warden_ID': idcontroller.text,
          'Hostel': hostelcontroller.text,
          'Phone': phonecontroller.text,
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
                Text('JIJI!!',
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
                    hintText: 'Enter your Warden ID',
                    obscureText: false),
                SizedBox(
                  height: 5,
                ),

                //Enter your Hostel Name
                MyTextField(
                    controller: hostelcontroller,
                    hintText: 'Enter your Hostel name',
                    obscureText: false),

                SizedBox(
                  height: 5,
                ),

                //Enter your Phone No
                MyTextField(
                    controller: phonecontroller,
                    hintText: 'Enter your Phone No',
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
