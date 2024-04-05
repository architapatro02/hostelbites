import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown[300],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //section name
              Text(
                sectionName,
                style: GoogleFonts.alef(
                    // Example font from Google Fonts, you can replace it with any other font
                    fontSize: 18,
                    color: Colors.white // Adjust the font size as needed
                    ),
              ),

              //edit button
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.edit),
                color: Colors.white60,
              )
            ],
          ),
          //text
          Text(
            text,
            style: GoogleFonts.alata(
              // Example font from Google Fonts, you can replace it with any other font
              fontSize:17, // Adjust the font size as needed
            ),
          ),
        ],
      ),
    );
  }
}
