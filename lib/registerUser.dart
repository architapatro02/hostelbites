import 'package:hostelbites/loginUser.dart';
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
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left:80,top: 100),
              child: Text(
                'Hostel Bites',
                style: TextStyle(color: Colors.black87,fontSize: 50),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.25,right: 35,left: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Uihelper.CustomTextField(namecontroller, 'Name', Icons.person_2_outlined, false),
                    Uihelper.CustomTextField(idcontroller, 'ID', Icons.article_outlined, false),
                    Uihelper.CustomTextField(emailcontroller, 'Email', Icons.email_outlined, false),
                    Uihelper.CustomTextField(passcontroller, 'Password', Icons.password_sharp, true),
                    Uihelper.CustomButton(() { }, 'SignUp'),

                    // TextField(
                    //   //style: TextStyle(color: Colors.white),
                    //   decoration: InputDecoration(
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: BorderSide(
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //             color: Colors.black87
                    //         ),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       fillColor: Colors.deepOrangeAccent,
                    //       filled: true,
                    //       hintText: 'Student Name',
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(20)
                    //       )
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // TextField(
                    //   //style: TextStyle(color: Colors.white),
                    //   decoration: InputDecoration(
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: BorderSide(
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //             color: Colors.black87
                    //         ),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       fillColor: Colors.deepOrangeAccent,
                    //       filled: true,
                    //       hintText: 'Student Id',
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
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: BorderSide(
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //             color: Colors.black87
                    //         ),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       fillColor: Colors.deepOrangeAccent,
                    //       filled: true,
                    //       hintText: 'Password',
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(20)
                    //       )
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sign Up',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.orange,
                          child: IconButton(
                            color: Colors.black,
                            onPressed: (){},
                            icon: Icon(
                                Icons.arrow_forward),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

    );
  }
}
