import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostelbites/components/mybutton.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() =>  _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen>{

  final _textController =TextEditingController();
  String? _selectedType;
  //String userPost='';
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
            Icon(Icons.feedback),
            SizedBox(width: 2),
            Text('Feedback',)
          ],),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(height: 200,
              color: Colors.brown[300],
              child: Center(
                child: Text('Feedback !!!',
                    style:GoogleFonts.roboto(fontSize: 40,),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: DropdownButton<String>(
              value: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
              items: const [
                DropdownMenuItem(
                  child: Text('Select an option'),
                  value: null,
                ),
                DropdownMenuItem(
                  child: Text('Breakfast'),
                  value: 'breakfast',
                ),
                DropdownMenuItem(
                  child: Text('Lunch'),
                  value: 'lunch',
                ),
                DropdownMenuItem(
                  child: Text('Snacks'),
                  value: 'snacks',
                ),
                DropdownMenuItem(
                  child: Text('Dinner'),
                  value: 'dinner',
                ),
              ],
            ),
          ),
          if (_selectedType != null) ...[
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Enter your feedback here',
              ),
            ),
            const SizedBox(height: 20),
            MyButton(onTap: (){}, text: 'Submit'),
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle feedback submission here
            //   },
            //   style: ElevatedButton.styleFrom(
            //       minimumSize: Size.fromHeight(30)
            //   ),
            //   child: const Text('Submit'),
            // ),
          ],
        ],
      ),
    );
  }
}
