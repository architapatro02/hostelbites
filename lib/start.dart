import 'package:flutter/material.dart';
import 'package:hostelbites/loginUser.dart';

class MyStart extends StatefulWidget {
  const MyStart({super.key});

  @override
  State<MyStart> createState() => _MyStartState();
}

class _MyStartState extends State<MyStart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Buttons"),
          foregroundColor: Colors.orange,
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.orangeAccent,
              child: Center(child: Text('Login As', style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontFamily: 'FontMain'),
              )),
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              // child: Text(
              //   'Login As',
              //   style: TextStyle(color: Colors.orange,fontSize: 50),
              // ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.5,left: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
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
                    onPressed: (){},
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

            )
          ],
        ),
      ),
    );
  }
}
