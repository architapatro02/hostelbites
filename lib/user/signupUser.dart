import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostelbites/user/homeUser.dart';
import 'package:hostelbites/user/loginUser.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/uiHelper.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController namecontroller=TextEditingController();
  TextEditingController idcontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passcontroller=TextEditingController();

  signUp(String name,String id,String email,String password)async{
    if(email=="" && password==""){
      Uihelper.CustomAlertBox(context, "Enter Required Fields");
    }
    else{
      UserCredential? usercredential;
      try{
        usercredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome()));
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
              image: AssetImage('assets/images/register2.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.01,right: 35,left: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Register Yourself',style: TextStyle(
                        fontSize: 35,fontWeight: FontWeight.bold
                      ),
                      ),
                      Uihelper.CustomTextField(namecontroller, 'Name', Icons.person_2_outlined, false),
                      Uihelper.CustomTextField(idcontroller, 'ID', Icons.article_outlined, false),
                      Uihelper.CustomTextField(emailcontroller, 'Email', Icons.email_outlined, false),
                      Uihelper.CustomTextField(passcontroller, 'Password', Icons.password_sharp, true),
                      Uihelper.CustomButton(() {
                        signUp(namecontroller.text.toString(), idcontroller.text.toString(), emailcontroller.text.toString(), passcontroller.text.toString());
                      }, 'SignUp'),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>const MyLogin())
                            );
                          }, child: Text(
                            'Already Registered?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20,
                              color: Colors.orange,
                            ),
                          ),
                            style: ButtonStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
