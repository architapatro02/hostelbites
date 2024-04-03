import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostelbites/warden/task.dart';

class Tasks extends StatelessWidget {
  final tasksList= Task.generateTasks();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
            itemCount: tasksList.length,
            itemBuilder: (BuildContext context, int index) {
              final task = tasksList[index];
              return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child:SizedBox(
                    height: 150,
                  child: tasksList[index].islast
                      ? _builderAddTask()
                      : _builderTask(context, tasksList[index])),
              );
            }
        ),
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
          image: DecorationImage(
            image: AssetImage(task.backgroundImage!
          ), // Use backgroundImage here
          fit: BoxFit.cover,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center
          ,
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
                color: Colors.brown[900],
              ),
            )
          ],
        ),
      ),
    );
  }



}
