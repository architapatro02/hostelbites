import 'package:flutter/material.dart';
import 'package:hostelbites/user/loginUser.dart';
import 'package:hostelbites/warden/loginWarden.dart';

class MyStart extends StatefulWidget {
  const MyStart({super.key});

  @override
  State<MyStart> createState() => _MyStartState();
}

class _MyStartState extends State<MyStart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg1.jpg'), fit: BoxFit.cover)),
      //debugShowCheckedModeBanner: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.2,top: MediaQuery.of(context).size.height*0.05),
              child: Text(
                'Hostel Bites',
                style: TextStyle(color: Colors.orangeAccent,fontSize: 50,fontFamily: 'FontMain',fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login As', style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87,
                    ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context)=>const MyLogin())
                        );
                      },
                      child: Text('Student'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.orange),
                        foregroundColor: MaterialStateProperty.all(Colors.black)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context)=>const MyLoginW())
                        );
                      },
                      child: Text('Warden'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.orange),
                          foregroundColor: MaterialStateProperty.all(Colors.black)
                      ),
                    )
                  ],
                ),
                // child: ElevatedButton(
                //   onPressed: (){},
                //   child: Text('STUDENT'),
                //   style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                //       foregroundColor: MaterialStateProperty.all(Colors.black)
                //   ),
                // ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
