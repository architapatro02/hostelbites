import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoPremium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.brown[400],
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white30, shape: BoxShape.circle),
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HOSTEL BITES',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Letss Manage Our Hostel',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        )
                      ])
                ],
              )),
        ],
      ),
    );
  }
}
