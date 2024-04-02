import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/components/mybutton.dart';
import 'package:hostelbites/components/mytextfield.dart';

class MyRegisterPageW extends StatefulWidget {
  final Function()? onTap;
  const MyRegisterPageW({Key? key, required this.onTap});

  @override
  State<MyRegisterPageW> createState() => _MyRegisterPageWState();
}

class _MyRegisterPageWState extends State<MyRegisterPageW> {
  //Text Editing controller
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController hostelController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  String? _errorMessage;

  // Function to reset error message
  void _resetError() {
    setState(() {
      _errorMessage = null;
    });
  }

  // Function to validate name field
  bool _validateName(String value) {
    return value.isNotEmpty && value.length <= 30;
  }

  // Function to validate warden ID
  bool _validateWardenID(String value) {
    return value.isNotEmpty && value.length == 10; // Assuming Warden ID length is 10
  }

  // Function to validate hostel name
  bool _validateHostelName(String value) {
    return value.isNotEmpty;
  }

  // Function to validate phone number
  bool _validatePhone(String value) {
    return value.isNotEmpty && RegExp(r'^[6-9]\d{9}$').hasMatch(value);
  }

  bool _validateEmail(String value) {
    // Check if the length is not more than 80 characters
    if (value.length > 80) {
      return false;
    }

    // Check if the last 14 characters are "@banasthali.in"
    if (!value.endsWith('@banasthali.in')) {
      return false;
    }

    // Check if all alphabets are in lowercase
    if (value.toLowerCase() != value) {
      return false;
    }

    // Check if there is an underscore after the first 10 characters
    if (value.indexOf('_') != 10) {
      return false;
    }

    // Check if the first 10 characters contain only alphanumeric (first 5 alphabets, next 5 numeric)
    String firstPart = value.substring(0, 10);
    RegExp firstPartRegex = RegExp(r'^[a-zA-Z]{5}[0-9]{5}$');
    if (!firstPartRegex.hasMatch(firstPart)) {
      return false;
    }

    // Extract name from the email and convert it to lowercase
    String nameAfterUnderscore = value.substring(11, value.indexOf('@'));
    String firstName = nameAfterUnderscore.split(' ')[0].toLowerCase();

    // Check if the name after underscore matches the first word of the "Name" field in lowercase
    return firstName == _getFirstName().toLowerCase();
  }

  String _getFirstName() {
    // Retrieve the name from the "Name" field and extract the first word
    String name = nameController.text.trim();
    List<String> nameParts = name.split(' ');
    return nameParts[0];
  }

  // Function to validate password
  bool _validatePassword(String value) {
    // Implement your password validation logic here
    String pattern = r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[]:;<>,.?/~_+-=|\]).{8,32}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  // Sign up method
  void signUserUp() async {
    // Reset error message
    _resetError();

    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Check if pass = confirm pass
    if (passController.text != confirmPassController.text) {
      _showErrorMessage("Passwords don't match");
      return;
    }

    // Validate all fields
    if (!_validateName(nameController.text) ||
        !_validateWardenID(idController.text) ||
        !_validateHostelName(hostelController.text) ||
        !_validatePhone(phoneController.text) ||
        !_validateEmail(emailController.text) ||
        !_validatePassword(passController.text)) {
      _showErrorMessage("Please enter valid data");
      return;
    }

    // Try creating the user
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      // After creating user, set specific document ID for the user in 'warden' collection
      String? userId = userCredential.user!.email; // Get the UID
      DocumentReference userDocRef =
      FirebaseFirestore.instance.collection("warden").doc(userId);

      // Check if the 'warden' collection already has a document with the user ID
      if (!(await userDocRef.get()).exists) {
        // If not, create the document
        await userDocRef.set({
          'Name': nameController.text,
          'Warden_ID': idController.text,
          'Hostel': hostelController.text,
          'Phone': phoneController.text,
          'Email': emailController.text,
        });
      }

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop the loading circle
      Navigator.pop(context);
      // Show error message
      _showErrorMessage(e.code);
    }
  }

  // Error message to user
  void _showErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
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
                Text(
                  'JIJI!!',
                  style: TextStyle(
                    fontSize: 52,
                  ),
                ),
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
                  controller: nameController,
                  hintText: 'Enter your Name',
                  obscureText: false,
                  validator: _validateName,
                ),
                SizedBox(
                  height: 5,
                ),

                //Enter your ID
                MyTextField(
                  controller: idController,
                  hintText: 'Enter your Warden ID',
                  obscureText: false,
                  validator: _validateWardenID,
                ),
                SizedBox(
                  height: 5,
                ),

                //Enter your Hostel Name
                MyTextField(
                  controller: hostelController,
                  hintText: 'Enter your Hostel name',
                  obscureText: false,
                  validator: _validateHostelName,
                ),

                SizedBox(
                  height: 5,
                ),

                //Enter your Phone No
                MyTextField(
                  controller: phoneController,
                  hintText: 'Enter your Phone No',
                  obscureText: false,
                  validator: _validatePhone,
                ),
                SizedBox(
                  height: 5,
                ),

                //Enter your email
                MyTextField(
                  controller: emailController,
                  hintText: 'Enter your Email',
                  obscureText: false,
                  validator: _validateEmail,
                ),
                SizedBox(
                  height: 5,
                ),

                //Enter your password
                MyTextField(
                  controller: passController,
                  hintText: 'Enter your Password',
                  obscureText: true,
                  validator: _validatePassword,
                ),
                SizedBox(
                  height: 5,
                ),

                //Confirm your password
                MyTextField(
                  controller: confirmPassController,
                  hintText: 'Confirm your Password',
                  obscureText: true,
                  validator: _validatePassword,
                ),
                SizedBox(
                  height: 15,
                ),

                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
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
