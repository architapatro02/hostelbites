import 'package:hostelbites/registerUser.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/uiHelper.dart';

import 'homeUser.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}


class _MyLoginState extends State<MyLogin> {
  TextEditingController idcontroller=TextEditingController();
  TextEditingController passcontroller=TextEditingController();
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
                    Uihelper.CustomTextField(idcontroller, 'Student ID', Icons.email_rounded, false),
                    Uihelper.CustomTextField(passcontroller, 'Password', Icons.password_outlined, true),
                    Uihelper.CustomButton(() {}, 'Login'),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       fillColor: Colors.deepOrangeAccent,
                    //       filled: true,
                    //       hintText: 'Student Id',
                    //       suffixIcon: Icon(Icons.email_rounded),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(20)
                    //       )
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // TextField(
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //       fillColor: Colors.deepOrangeAccent,
                    //       filled: true,
                    //       hintText: 'Password',
                    //       suffixIcon: Icon(Icons.password_outlined),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(20)
                    //       )
                    //   ),
                    // ),
                    // ElevatedButton(
                    //   onPressed: (){
                    //     Navigator.pushReplacement(context, MaterialPageRoute(
                    //         builder: (context)=>const MyLogin())
                    //     );
                    //   },
                    //   child: Text('Student'),
                    //   style: ButtonStyle(
                    //       backgroundColor: MaterialStateProperty.all(Colors.orange),
                    //       foregroundColor: MaterialStateProperty.all(Colors.black)
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Sign In',
                    //       style: TextStyle(
                    //           color: Colors.orange,
                    //           fontSize: 27,
                    //           fontWeight: FontWeight.w700),
                    //     ),
                    //     CircleAvatar(
                    //       radius: 30,
                    //       backgroundColor: Colors.orange,
                    //       child: IconButton(
                    //         color: Colors.black,
                    //         onPressed: (){
                    //           Navigator.pushReplacement(context, MaterialPageRoute(
                    //               builder: (context)=>const UserHome())
                    //           );
                    //         },
                    //         icon: Icon(Icons.arrow_forward),
                    //       ),
                    //     )
                    //   ],
                    // ),
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
                        TextButton(onPressed: (){}, child: Text('Forget Password',style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          color: Colors.orange,
                        ),
                        )),
                      ],
                    ),
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
