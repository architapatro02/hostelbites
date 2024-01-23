import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/auth/otpScreen.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authorization"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phonecontroller,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "(code) Enter Phone Number",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verficationid, int? resendtoken) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(verificationid: verficationid,)));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                    phoneNumber: phonecontroller.text.toString());
              },
              child: Text("Verify Phone Number"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
            ),
          )
        ],
      ),
    );
  }
}
