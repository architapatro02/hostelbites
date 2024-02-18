import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(92 , 64, 51, 1),
              Color.fromRGBO(188, 170, 164, 1),
            ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor:Colors.transparent ,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white),
                      Icon(
                          Icons.logout,
                          size: 30,
                          color: Colors.white),
                    ],
                  ),
                  SizedBox(
                      height: 20),
                  Text(
                      'My\nProfile',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aladin(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white)
                  ),
                  SizedBox(
                      height: 20),
                  Container(
                    height: height*0.4 ,
                    //color: Colors.brown[900],
                    child: LayoutBuilder(
                      builder: (context,constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerwidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.5,
                                width: innerwidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.brown[700],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                        'Harshita Garg',
                                        style: GoogleFonts.playfairDisplay(color: Colors.white,fontSize: 40)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top:0,
                              left:0,
                              right:0,
                              child: Center(
                                child: Container(
                                  child:
                                  Image.asset(
                                    'assets/images/profile.png',
                                    width:innerwidth*0.45,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ) ,
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}


