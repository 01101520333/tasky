import 'package:flutter/material.dart';
import 'package:tasky/core/network/resulet_firebase.dart';
import 'package:tasky/core/utils/assets_icons.dart';
import 'package:tasky/core/utils/colors_app.dart';
import 'package:tasky/core/widgets/app_dialog.dart';
import 'package:tasky/features/home/data/firebase/home_firebase.dart';
import 'package:tasky/features/home/data/models/app_task_model.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key, required this.task});
  static const String routeName = "TaskScreen";
  final AppTaskModel task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 24,
          children: [
            Text(
              task.title ?? "",
              style: TextStyle(
                fontSize: 20,
                fontWeight: .w400,
                color: ColorsApp.textColor,
              ),
            ),

            Text(
              task.description ?? "",
              style: TextStyle(
                fontSize: 18,
                fontWeight: .w400,
                color: Color(0xff6E6A7C),
              ),
            ),
            ItemRowWidget(
              iconPath: AssetsIcons.dateIcon,
              containerText: task.date?.day.toString() ?? "Today",
              typeText: "Task Time :",
            ),

            ItemRowWidget(
              iconPath: AssetsIcons.priorityIcon,
              containerText: task.priority.toString(),
              typeText: "Task Priority :",
            ),

            GestureDetector(
              onTap: () {
                deleteTask(task.id!, context);
              },
              child: Row(
                children: [
                  Image.asset(AssetsIcons.trashIcon),
                  SizedBox(width: 10),
                  Text(
                    "Delete Task",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .w400,
                      color: Color(0xffFF4949),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteTask(String id, BuildContext context) async {
    AppDialog.showLoadingUi(context);
    final ResuletFirebase<bool> resulte = await HomeFirebase.deleteTask(id);
    if (!context.mounted) return;
    Navigator.pop(context);
    switch (resulte) {
      case Success<bool>():
        Navigator.pop(context);
      case Error<bool>():
        AppDialog.showErrorUi(context: context, error: resulte.error);
    }
  }
}

class ItemRowWidget extends StatelessWidget {
  const ItemRowWidget({
    super.key,
    required this.iconPath,
    required this.containerText,
    required this.typeText,
  });
  final String iconPath;
  final String containerText;
  final String typeText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath),
        SizedBox(width: 10),
        Text(
          typeText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: .w400,
            color: ColorsApp.textColor,
          ),
        ),

        Spacer(),

        Container(
          color: Color(0xff6E6A7C36),
          height: 36,
          width: 64,
          child: Center(
            child: Text(
              containerText,
              textAlign: .center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: .w400,
                color: Color(0xff000000),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
