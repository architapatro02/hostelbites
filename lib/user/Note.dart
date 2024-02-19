import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title:const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet),
            SizedBox(width: 10),
            Text('Note')
          ],),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 100,
              color: Colors.brown[200],
              child: const Center(
                child: Text('SPECIAL NOTE !!!',
                    style:TextStyle(fontSize:25) ,
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(20.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'what\'s on your mind?',
                      border:  const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: (){
                          _textController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      userPost =_textController.text;
                    },
                    color: Colors.brown[200],
                    child: const Text('Post'),
                  ),
                ],
              ))
        ],

      ),
    );
  }
}
