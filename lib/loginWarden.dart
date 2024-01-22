import 'package:hostelbites/registerUser.dart';
import 'package:flutter/material.dart';

import 'homeUser.dart';

class MyLoginW extends StatefulWidget {
  const MyLoginW({Key? key}) : super(key: key);

  @override
  _MyLoginWState createState() => _MyLoginWState();
}


class _MyLoginWState extends State<MyLoginW> {
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
                style: TextStyle(color: Colors.orangeAccent,fontSize: 50),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.28,right: 35,left: 35),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.deepOrangeAccent,
                          filled: true,
                          hintText: 'Warden Id',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.deepOrangeAccent,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sign In',
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
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>const UserHome())
                              );
                            },
                            icon: Icon(Icons.arrow_forward),
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
