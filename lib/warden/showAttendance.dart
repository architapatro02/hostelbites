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
        title: Text('Attendance Records',
        style: TextStyle(
        color: Colors.brown[900],
        ),
        ),
        backgroundColor: Colors.brown[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('attendance').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // Count variables for each category
            int breakfastPresent = 0, lunchPresent = 0, snacksPresent = 0, dinnerPresent = 0;
            int breakfastAbsent = 0, lunchAbsent = 0, snacksAbsent = 0, dinnerAbsent = 0;

            // Process each document in the snapshot
            snapshot.data!.docs.forEach((DocumentSnapshot document) {
              Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

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
                // Attendance summary section
                // Text(
                //   'Attendance',
                //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                // ),
                SizedBox(height: 16),

                // Meal category blocks
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMealCategoryBlock('Breakfast', breakfastPresent, breakfastAbsent),
                    SizedBox(width: 16),
                    _buildMealCategoryBlock('Lunch', lunchPresent, lunchAbsent),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMealCategoryBlock('Snacks', snacksPresent, snacksAbsent),
                    SizedBox(width: 16),
                    _buildMealCategoryBlock('Dinner', dinnerPresent, dinnerAbsent),
                  ],
                ),
                SizedBox(height: 20),

                // List of attendance records
                Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

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
  Widget _buildMealCategoryBlock(String category, int present, int absent) {
    return Expanded(
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
    );
  }
}

