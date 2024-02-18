import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MenuPage extends StatefulWidget {
  //const MenuPage({super.key});
  @override
  State<MenuPage> createState() => _MenuPageState();
}
class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(
      //   title: const Text('Menu'),
      //   centerTitle: true,
      //   //backgroundColor: Colors.brown[300],
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 2),
            Text('Menu')
          ],),
      ),
      body: ListView(
        //physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 80,
              color: Colors.brown[200],
              child: Center(
                child: Text('TODAYS MENU !!!',
                    style: GoogleFonts.deliciousHandrawn(fontSize:50),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 150,
              color: Colors.brown[200],
              child: Text('BREAKFAST',
                  style: GoogleFonts.cuteFont(fontSize: 35)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 150,
              color: Colors.brown[200],
              child: Text('LUNCH',
                  style: GoogleFonts.cuteFont(fontSize: 35)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 150,
              color: Colors.brown[200],
              child: Text('SNACKS',
                  style: GoogleFonts.cuteFont(fontSize: 35)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 150,
              color: Colors.brown[200],
              child: Text('DINNER',
                  style:  GoogleFonts.cuteFont(fontSize: 35)),
            ),
          ),
        ],
      ),
    );
  }
}
