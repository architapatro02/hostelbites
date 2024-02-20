import 'package:flutter/material.dart';
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
      // appBar: AppBar(
      //   title:const Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Icon(Icons.feedback),
      //       SizedBox(width: 10),
      //       Text('Feedback')
      //     ],),
      // ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 100,
              color: Colors.brown[200],
              child: const Center(
                child: Text('FEEDBACK !!!',
                    style:TextStyle(fontSize:25) ,
                    textAlign: TextAlign.center),
              ),
            ),
          ),

          const SizedBox(height: 20),
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
