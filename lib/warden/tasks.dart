import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/warden/task.dart';

class Tasks extends StatelessWidget {
  final tasksList= Task.generateTasks();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: GridView.builder(
          itemCount: tasksList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
          ), itemBuilder: (BuildContext context, int index) =>
      tasksList[index].islast ?   _builderAddTask() : _builderTask(context, tasksList[index])),
    );
  }
  Widget _builderAddTask() {
    return Text('Add Task');
  }

  Widget _builderTask(BuildContext context, Task task) {
    return GestureDetector(
      onTap: () {
        // Handle click event for the task here
        // You can navigate to the corresponding page or perform any other action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => task.page!),
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: task.bgcolor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              task.iconData,
              color: task.iconColor,
              size: 35,
            ),
            SizedBox(height: 30),
            Text(
              task.title!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }



}
