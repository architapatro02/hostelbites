import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/uiHelper.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController emailcontroller=TextEditingController();
  forgotpassword(String email)async{
    if(email==""){
      return Uihelper.CustomAlertBox(context, "Enter Valid Email to Reset Password");
    }
    else{
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/register2.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text("Forgot Password"),
        //   centerTitle: true,
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Forget password",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.orange
            ),),
            SizedBox(height: 20),
            Uihelper.CustomTextField(emailcontroller, "Email", Icons.email_outlined, false),
            SizedBox(height: 30),
            Uihelper.CustomButton(() {
              forgotpassword(emailcontroller.text.toString());
            }, "Reset Password"),
        ],),
      ),
    );
  }
}
