import 'package:flutter/material.dart';
import 'package:tasky/features/home/data/models/app_task_model.dart';
import 'package:tasky/features/home/view/screens/task_screen.dart';

class HomeSection extends StatelessWidget {
  HomeSection({super.key, required this.tasks});
  List<AppTaskModel> tasks;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: tasks.length,
        itemBuilder: (context, index) => ItemTaskWidget(task: tasks[index]),
      ),
    );
  }
}

class ItemTaskWidget extends StatelessWidget {
  ItemTaskWidget({super.key, required this.task});
  AppTaskModel task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return TaskScreen(task: task);
            },
          ),
        );
      },
      child: Card(
        color: Color(0xffFFFFFF),
        child: ListTile(
          leading: Checkbox(
            value: task.isDone,
            shape: const CircleBorder(),
            activeColor: Color(0xff5F33E1),
            onChanged: (bool? newValue) {
              // setState(() {
              //   isCompleted = newValue!;
              // });
            },
          ), // Text
          trailing: Text(
            task.priority.toString(),
            style: TextStyle(color: Colors.black),
          ), // Text
          title: Text(task.title ?? "", style: TextStyle(color: Colors.black)),
          subtitle: Text(
            "today is : ${task.date!.day.toString()}",
            style: TextStyle(color: Colors.black),
          ), // Text
        ), // ListTile
      ),
    ); // Card
  }
}
