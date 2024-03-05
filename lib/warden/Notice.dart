import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
class SpecialNoteScreen extends StatefulWidget {
  const SpecialNoteScreen({Key? key}) : super(key: key);

  @override
  State<SpecialNoteScreen> createState() =>  _SpecialNoteScreenState();
}

class _SpecialNoteScreenState extends State<SpecialNoteScreen>{

  final _textController =TextEditingController();
  String userPost='';
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
            Icon(Icons.account_balance_wallet),
            SizedBox(width: 2),
            Text('Important Notice',)
          ],),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(height: 200,
              color: Colors.brown[300],
              child: Center(
                child: Text('IMPORTANT NOTICE',
                    style:TextStyle(fontSize: 35,),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(padding: const EdgeInsets.all(20.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Important notice for student!',
                      border:  const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: (){
                          _textController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  MaterialButton(
                    onPressed: (){
                      userPost =_textController.text;
                    },
                    color: Colors.brown,
                    child: const Text('Post'),
                  ),
                ],
              ))
        ],

      ),
    );
  }
}
