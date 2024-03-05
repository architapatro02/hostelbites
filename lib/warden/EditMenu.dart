import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';


class EditMenu extends StatefulWidget {
  const EditMenu({Key? key}) : super(key: key);

  @override
  _EditMenuState createState() =>  _EditMenuState();
}

class _EditMenuState  extends State<EditMenu>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown[500],
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit),
            SizedBox(width: 2),
            Text('Edit Menu',)
          ],),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(height: 150,
              color: Colors.brown[300],
              child: Center(
                child: Text('Edit Menu',
                    style:TextStyle(fontSize: 40,),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('BREAKFAST',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child:
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.brown[300],
                filled: true,
                hintText: 'Breakfast',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('LUNCH',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child:
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.brown[300],
                filled: true,
                hintText: 'Lunch',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('SNACKS',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child:
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.brown[300],
                filled: true,
                hintText: 'Snacks',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('DINNER',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child:
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.brown[300],
                filled: true,
                hintText: 'Dinner',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),


        ],
      ),


    );
  }
}
