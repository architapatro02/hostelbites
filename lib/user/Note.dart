import 'package:flutter/material.dart';

class SpecialNoteScreen extends StatefulWidget {
  const SpecialNoteScreen({Key? key}) : super(key: key);

  @override
  State<SpecialNoteScreen> createState() =>  _SpecialNoteScreenState();
}

class _SpecialNoteScreenState extends State<SpecialNoteScreen>{

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
        ],
      ),
    );
  }
}


// body: Padding(
//   padding: const EdgeInsets.all(16),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       const SizedBox(height: 16),
//       const Text(
//         'Welcome to the Special Note for Students!',
//         style: TextStyle(
//           color: Colors.brown,
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(height: 16),
//       const Text(
//         'This is a special note for students that contains some important information or announcements. Please read it carefully and take necessary actions if needed.',
//         style: TextStyle(
//           fontSize: 18,
//         ),
//       ),
//       const SizedBox(height: 16),
//     ],
//   ),
// ),
