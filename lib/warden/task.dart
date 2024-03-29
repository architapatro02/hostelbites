import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/user/NoteStudent.dart';
import 'package:hostelbites/warden/EditMenu.dart';
import 'package:hostelbites/warden/ManageStudent.dart';
import 'package:hostelbites/warden/ViewFeedbacks.dart';
import 'package:hostelbites/warden/showAttendance.dart';

class Task {
  IconData? iconData;
  String? title;
  Color? bgcolor;
  Color? iconColor;
  Widget? page; // Change this to Widget type
  bool islast;

  Task({this.iconData, this.title, this.bgcolor, this.iconColor, this.page, this.islast = false}); // Add 'page' parameter

  static List<Task> generateTasks() {
    return [
      Task(
        iconData: Icons.manage_accounts,
        title: 'Manage Students',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: ManageStudentsPage(),
      ),
      Task(
        iconData: Icons.edit,
        title: 'Edit Menu',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: EditMenu(),
      ),
      Task(
        iconData: Icons.local_drink,
        title: 'Milk Details',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: null, // Set appropriate widget for Milk Details page
      ),
      Task(
        iconData: Icons.line_style_rounded,
        title: 'View Attendance',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: ShowAttendance(),
      ),
      Task(
        iconData: Icons.note_alt_rounded,
        title: 'Important Notice',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: SpecialNoteScreen(),
      ),
      Task(
        iconData: Icons.feedback_rounded,
        title: 'Feedback',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: ShowFeedbackPage(),
      ),
    ];
  }
}
