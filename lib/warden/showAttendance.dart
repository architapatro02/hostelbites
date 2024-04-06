import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowAttendance extends StatefulWidget {
  @override
  _ShowAttendanceState createState() => _ShowAttendanceState();
}

class _ShowAttendanceState extends State<ShowAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[800],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.brown[900]),
        title: Text(
          'Attendance Records',
          style: TextStyle(
            color: Colors.brown[900],
          ),

        ),
        backgroundColor: Colors.brown[300],
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('attendance').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Count variables for each category
              int breakfastPresent = 0,
                  lunchPresent = 0,
                  snacksPresent = 0,
                  dinnerPresent = 0;
              int breakfastAbsent = 0,
                  lunchAbsent = 0,
                  snacksAbsent = 0,
                  dinnerAbsent = 0;

              // Process each document in the snapshot
              snapshot.data!.docs.forEach((DocumentSnapshot document) {
                Map<String, dynamic>? data =
                    document.data() as Map<String, dynamic>?;

                if (data != null) {
                  // Increment counts based on the meal category and attendance status
                  if (data['Breakfast'] == 'present') {
                    breakfastPresent++;
                  } else {
                    breakfastAbsent++;
                  }

                  if (data['Lunch'] == 'present') {
                    lunchPresent++;
                  } else {
                    lunchAbsent++;
                  }

                  if (data['Snacks'] == 'present') {
                    snacksPresent++;
                  } else {
                    snacksAbsent++;
                  }

                  if (data['Dinner'] == 'present') {
                    dinnerPresent++;
                  } else {
                    dinnerAbsent++;
                  }
                }
              });

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),

                  // Meal category blocks
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildClickableMealCategoryBlock(
                          'Breakfast', breakfastPresent, breakfastAbsent),
                      SizedBox(width: 16),
                      _buildClickableMealCategoryBlock(
                          'Lunch', lunchPresent, lunchAbsent),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildClickableMealCategoryBlock(
                          'Snacks', snacksPresent, snacksAbsent),
                      SizedBox(width: 16),
                      _buildClickableMealCategoryBlock(
                          'Dinner', dinnerPresent, dinnerAbsent),
                    ],
                  ),
                  SizedBox(height: 20),

                  // List of attendance records
                  Expanded(
                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic>? data =
                            document.data() as Map<String, dynamic>?;

                        if (data == null) {
                          return Container(); // Skip null data
                        }

                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              'Name: ${data['Name']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Breakfast: ${data['Breakfast']}'),
                                Text('Lunch: ${data['Lunch']}'),
                                Text('Snacks: ${data['Snacks']}'),
                                Text('Dinner: ${data['Dinner']}'),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
  }

  // Helper method to build a rounded square block for a meal category
  Widget _buildClickableMealCategoryBlock(
      String category, int present, int absent) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _showStudentsList(category);
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.brown[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                category,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Present: $present'),
              Text('Absent: $absent'),
            ],
          ),
        ),
      ),
    );
  }

  void _showStudentsList(String category) {
    // Fetch the list of students who submitted data for the selected meal category from Firestore
    FirebaseFirestore.instance
        .collection('attendance')
        .where(category, isEqualTo: 'present')
        .get()
        .then((QuerySnapshot querySnapshot) {
      // Extract the names and room numbers of students who submitted data for the selected meal category
      List<String> studentDetails =
          querySnapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

        if (data != null) {
          String name = data['Name'] as String;
          String room =
              data['Room'] as String; // Assuming 'Room' is a String field
          return '$name - Room: $room';
        } else {
          return '';
        }
      }).toList();

      // Convert the list of student details to a list of ListTile widgets with custom styling
      List<Widget> studentTiles = studentDetails.map((String details) {
        List<String> detailsList = details.split(
            ' - Room: '); // Split the details to get name and room separately
        String name = detailsList[0];
        String room = detailsList.length > 1
            ? detailsList[1]
            : ''; // Ensure room is not null

        return Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.brown[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tileColor: Colors.transparent,
            title: Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto', // Change the font family here
              ),
            ),
            subtitle: Text(
              'Room: $room',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto', // Change the font family here
              ),
            ),
            leading: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ),
        );
      }).toList();

      // Show the list of students in an AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Students for $category',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto', // Change the font family here
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: studentTiles, // Use the list of ListTile widgets here
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto', // Change the font family here
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
