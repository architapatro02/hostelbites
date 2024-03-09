import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/auth/authpagesU.dart';
import 'package:hostelbites/auth/authpagesW.dart';

class MyStart extends StatefulWidget {
  const MyStart({super.key});

  @override
  State<MyStart> createState() => _MyStartState();
}

class _MyStartState extends State<MyStart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown.shade300,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.food_bank_outlined, size: 60),
                    Text(
                      'Hostel Bites',
                      style: GoogleFonts.playfairDisplay(fontSize: 52),
                    ),
                    SizedBox(height: 50,),
                    Text(
                      'Login As',
                      style: GoogleFonts.roboto(fontSize: 30),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AuthPage()));
                      },
                      child: Text('Student'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white70),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AuthPageW()));
                      },
                      child: Text('Warden'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white70),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black)),
                    )
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
