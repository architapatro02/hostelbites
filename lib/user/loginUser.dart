import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostelbites/auth/forgotpassword.dart';
import 'package:hostelbites/user/homeUser.dart';
import 'package:hostelbites/auth/phoneAuth.dart';
import 'package:hostelbites/user/signupUser.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/uiHelper.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}


class _MyLoginState extends State<MyLogin> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passcontroller=TextEditingController();

  login(String email,String password)async{
    if(email=="" && password==""){
      return Uihelper.CustomAlertBox(context, "Enter Required Fields");
    }
    else{
      UserCredential? usercredential;
      try{
        usercredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context)=>UserHome()));
        });
      }
      on FirebaseAuthException catch(ex){
        return Uihelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left:80,top: 150),
              child: Text(
                'Hostel Bites',
                style: TextStyle(color: Colors.orangeAccent,fontSize: 50,fontFamily: 'FontMain',fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.28,right: 35,left: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Uihelper.CustomTextField(emailcontroller, 'Email', Icons.email_rounded, false),
                    Uihelper.CustomTextField(passcontroller, 'Password', Icons.password_outlined, true),
                    Uihelper.CustomButton(() {
                      login(emailcontroller.text.toString(), passcontroller.text.toString());
                    }, 'Login'),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context)=>const MyRegister())
                          );
                        }, child: Text('Sign Up',style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          color: Colors.orange,
                        ),
                        )),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>const ForgotPass())
                          );
                        }, child: Text('Forget Password',style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          color: Colors.orange,
                        ),
                        )),
                      ],
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>const PhoneAuth())
                      );
                    }, child: Text('Login via OTP',style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      color: Colors.orange,
                    ),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
