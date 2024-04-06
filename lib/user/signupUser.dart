import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/components/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/components/mytextfield.dart';

class MyRegisterPage extends StatefulWidget {
  final Function()? onTap;
  const MyRegisterPage({Key? key, required this.onTap});

  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  //Text Editing controllor
  TextEditingController nameController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController hostelController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  // Function to validate name field
  bool _validateName(String value) {
    String pattern = r'^[A-Za-z][a-zA-Z ]{0,29}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  // Function to validate student ID
  bool _validateStudentID(String value) {
    String pattern = r'^[A-Z]{5}[0-9]{5}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  // Function to validate hostel name
  bool _validateHostelName(String value) {
    return value.length >= 4;
  }

  // Function to validate room number
  bool _validateRoomNo(String value) {
    String pattern = r'^[0-9]{1,3}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
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
    // Implement password validation logic here
    // Regex pattern to match passwords meeting the specified criteria
    String pattern =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[\]:;<>,.?/~_+-=|\\]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  void signUserUp() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Check if pass = confirm pass
    if (passController.text != confirmPassController.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords don't match");
      return;
    }

    // Validate all fields
    if (!_validateName(nameController.text) ||
        !_validateStudentID(studentIdController.text) ||
        !_validateHostelName(hostelController.text) ||
        !_validateRoomNo(roomController.text) ||
        !_validateEmail(emailController.text) ||
        !_validatePassword(passController.text)) {
      Navigator.pop(context);
      showErrorMessage("Please enter valid data");
      return;
    }

    // Try sending the registration request
    try {
      await sendRegistrationRequest();
      Navigator.pop(context);
      showSuccessMessage("Registration request sent successfully");
    } catch (e) {
      // Pop the loading circle
      Navigator.pop(context);
      // Show error message
      showErrorMessage("Failed to send registration request");
    }
  }

  // Function to send registration request
  Future<void> sendRegistrationRequest() async {
    // Create the registration request data
    Map<String, dynamic> requestData = {
      'Name': nameController.text,
      'ID': studentIdController.text,
      'Hostel': hostelController.text,
      'Room': roomController.text,
      'Email': emailController.text,
      'Password': passController.text,
    };

    try {
      // Save the registration request data to Firestore
      await FirebaseFirestore.instance
          .collection('registration_requests')
          .doc(emailController.text)
          .set(requestData);

      // Show success message to the user
      showSuccessMessage("Registration request sent successfully");
    } catch (e) {
      // Show error message to the user
      showErrorMessage("Failed to send registration request");
    }
  }

  // Function to show success message to the user
  void showSuccessMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }



  // Error message to user
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
                Text(
                  'Welcome',
                  style: GoogleFonts.montserrat(
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
                    validator: _validateName),

                SizedBox(
                  height: 5,
                ),

                //Enter your ID
                MyTextField(
                    controller: studentIdController,
                    hintText: 'Enter your Student ID',
                    obscureText: false,
                    validator: _validateStudentID),

                SizedBox(
                  height: 5,
                ),

                //Enter your Hostel Name
                MyTextField(
                    controller: hostelController,
                    hintText: 'Enter your Hostel name',
                    obscureText: false,
                    validator: _validateHostelName),

                SizedBox(
                  height: 5,
                ),

                //Enter your Room No
                MyTextField(
                    controller: roomController,
                    hintText: 'Enter your Room No',
                    obscureText: false,
                    validator: _validateRoomNo),

                SizedBox(
                  height: 5,
                ),

                //Enter your email
                MyTextField(
                    controller: emailController,
                    hintText: 'Enter your Email',
                    obscureText: false,
                    validator: _validateEmail),

                SizedBox(
                  height: 5,
                ),

                //Enter your password
                MyTextField(
                    controller: passController,
                    hintText: 'Enter your Password',
                    obscureText: true,
                    validator: _validatePassword),

                SizedBox(
                  height: 5,
                ),

                //Confirm your password
                MyTextField(
                    controller: confirmPassController,
                    hintText: 'Confirm your Password',
                    obscureText: true,
                    validator: _validatePassword),

                SizedBox(
                  height: 15,
                ),

                //Sign Up button
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),

                SizedBox(
                  height: 10,
                ),

                //Not registered yet?
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
