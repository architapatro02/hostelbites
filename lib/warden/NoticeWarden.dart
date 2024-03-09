import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialNoteScreen extends StatefulWidget {
  const SpecialNoteScreen({Key? key}) : super(key: key);

  @override
  State<SpecialNoteScreen> createState() => _SpecialNoteScreenState();
}

class _SpecialNoteScreenState extends State<SpecialNoteScreen> {
  final _textController = TextEditingController();
  String userPost = '';

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
            Text('Important Notice'),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              height: 200,
              color: Colors.brown[300],
              child: Center(
                child: Text(
                  'IMPORTANT NOTICE',
                  style: TextStyle(
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Important notice for students!',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textController.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                MaterialButton(
                  onPressed: () {
                    userPost = _textController.text;
                    // Call function to add notice to Firestore
                    addNoticeToFirestore(userPost);
                  },
                  color: Colors.brown,
                  child: const Text('Post'),
                ),
                const SizedBox(height: 20),
                // Section to show posted notice
                _buildPostedNoticeSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to add notice to Firestore
  Future<void> addNoticeToFirestore(String notice) async {
    try {
      // Get current date and time
      DateTime now = DateTime.now();
      String formattedDateTime = "${now.year}-${_addZeroIfNeeded(now.month)}-${_addZeroIfNeeded(now.day)} " +
          "${_addZeroIfNeeded(now.hour)}:${_addZeroIfNeeded(now.minute)}";

      // Store notice in Firestore
      await FirebaseFirestore.instance.collection('notice').add({
        'content': notice,
        'timestamp': formattedDateTime,
      });

      // Show a success dialog and clear text field
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Notice posted successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _textController.clear();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Handle the error
      print('Error adding notice to Firestore: $e');
    }
  }

  String _addZeroIfNeeded(int value) {
    // Add a leading zero if the value is less than 10
    return value < 10 ? '0$value' : value.toString();
  }

  // Function to delete notice from Firestore
  Future<void> deleteNotice(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('notice').doc(docId).delete();
    } catch (e) {
      print('Error deleting notice: $e');
    }
  }

  Widget _buildPostedNoticeSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('notice').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> notices = [];
          for (var doc in snapshot.data!.docs) {
            String content = doc['content'];
            String timestamp = doc['timestamp'];

            notices.add(
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    content,
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    timestamp,
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Call function to delete notice from Firestore
                      deleteNotice(doc.id);
                    },
                  ),
                ),
              ),
            );
          }
          return Column(
            children: notices,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
