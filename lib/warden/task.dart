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
        iconData: Icons.manage_accounts,
        title: 'Manage Students',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: ManageStudentsPage(),
        backgroundImage: 'assets/images/manage.jpg',

      ),
      Task(
        iconData: Icons.edit,
        title: 'Edit Menu',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: EditMenu(),
        backgroundImage: 'assets/images/menu.jpeg',
      ),
      Task(
        iconData: Icons.local_drink,
        title: 'Milk Details',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: ViewMilkDetails(),
        backgroundImage: 'assets/images/milkk.jpg',// Set appropriate widget for Milk Details page
      ),
      Task(
        iconData: Icons.line_style_rounded,
        title: 'View Attendance',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: ShowAttendance(),
        backgroundImage: 'assets/images/attendance.jpg',
      ),
      Task(
        iconData: Icons.note_alt_rounded,
        title: 'Important Notice',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: SpecialNoteScreen(),
        backgroundImage: 'assets/images/notice.jpg',
      ),
      Task(
        iconData: Icons.feedback_rounded,
        title: 'Feedback',
        bgcolor: Colors.brown[200],
        iconColor: Colors.brown[900],
        page: ShowFeedbackPage(),
        backgroundImage: 'assets/images/feedbackk.jpg',
      ),
    ];
  }
}
