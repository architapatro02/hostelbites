import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/warden/NoticeWarden.dart';
import 'package:hostelbites/warden/EditMenu.dart';
import 'package:hostelbites/warden/ManageStudent.dart';
import 'package:hostelbites/warden/ViewFeedbacks.dart';
import 'package:hostelbites/warden/ViewMilkDetails.dart';
import 'package:hostelbites/warden/showAttendance.dart';

class Task {
  IconData? iconData;
  String? title;
  Color? bgcolor;
  Color? iconColor;
  Widget? page;
  String? backgroundImage;// Change this to Widget type
  bool islast;


  Task({
    this.iconData,
    this.title,
    this.bgcolor,
    this.iconColor,
    this.page,
    this.backgroundImage,
    this.islast = false
  }); // Add 'page' parameter

  static List<Task> generateTasks() {
    return [
      Task(
        iconData: Icons.edit,
        title: 'Edit Menu',
        bgcolor: Colors.brown[200],
        iconColor: Colors.white,
        page: EditMenu(),
        backgroundImage: 'assets/images/r5.jpg',
      ),
      Task(
        iconData: Icons.line_style_rounded,
        title: 'View Attendance',
        bgcolor: Colors.brown[200],
        iconColor: Colors.white,
        page: ShowAttendance(),
        backgroundImage: 'assets/images/r5.jpg',
      ),
      Task(
        iconData: Icons.local_drink,
        title: 'Milk Details',
        bgcolor: Colors.brown[200],
        iconColor: Colors.white,
        page: ViewMilkDetails(),
        backgroundImage: 'assets/images/r5.jpg',// Set appropriate widget for Milk Details page
      ),
      Task(
        iconData: Icons.manage_accounts,
        title: 'Manage Students',
        bgcolor: Colors.brown[200],
        iconColor: Colors.white,
        page: ManageStudentsPage(),
        backgroundImage: 'assets/images/r5.jpg',
      ),


      Task(
        iconData: Icons.note_alt_rounded,
        title: 'Important Notice',
        bgcolor: Colors.brown[200],
        iconColor: Colors.white,
        page: SpecialNoteScreen(),
        backgroundImage: 'assets/images/r5.jpg',
      ),
      Task(
        iconData: Icons.feedback_rounded,
        title: 'Feedback',
        bgcolor: Colors.brown[200],
        iconColor: Colors.white,
        page: ShowFeedbackPage(),
        backgroundImage: 'assets/images/r5.jpg',
      ),
    ];
  }
}
