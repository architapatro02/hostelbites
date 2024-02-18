import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/mytextfield.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController _emailcontroller = TextEditingController();

  void passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Password reset link sent! Check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter your registered email and We will send you the password reset link link!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //email verified
          MyTextField(
              controller: _emailcontroller,
              hintText: 'Enter your Email',
              obscureText: false),
          SizedBox(height: 20),
          MaterialButton(
            onPressed: passwordReset,
            child: Text(
              'Reset password',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.brown[400],
          ),
        ],
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hostelbites/uiHelper.dart';
//
// class ForgotPass extends StatefulWidget {
//   const ForgotPass({super.key});
//
//   @override
//   State<ForgotPass> createState() => _ForgotPassState();
// }
//
// class _ForgotPassState extends State<ForgotPass> {
//   TextEditingController emailcontroller=TextEditingController();
//   forgotpassword(String email)async{
//     if(email==""){
//       return Uihelper.CustomAlertBox(context, "Enter Valid Email to Reset Password");
//     }
//     else{
//       FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/images/register2.jpg'), fit: BoxFit.cover)),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         // appBar: AppBar(
//         //   title: Text("Forgot Password"),
//         //   centerTitle: true,
//         // ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Forget password",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 35,
//               color: Colors.orange
//             ),),
//             SizedBox(height: 20),
//             //Uihelper.CustomTextField(emailcontroller, "Email", Icons.email_outlined, false),
//             SizedBox(height: 30),
//             // Uihelper.CustomButton(() {
//             //   forgotpassword(emailcontroller.text.toString());
//             // }, "Reset Password"),
//         ],),
//       ),
//     );
//   }
// }
