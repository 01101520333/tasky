import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky/core/network/resulet_firebase.dart';
import 'package:tasky/core/utils/assets_icons.dart';
import 'package:tasky/core/utils/validator_app.dart';
import 'package:tasky/core/widgets/app_dialog.dart';
import 'package:tasky/core/widgets/text_form_field_widget.dart';
import 'package:tasky/features/home/data/firebase/home_firebase.dart';
import 'package:tasky/features/home/data/models/app_task_model.dart';
import 'package:tasky/features/home/view/widgets/selected_task_priority.dart';

class BottomSheetAddTask extends StatefulWidget {
  const BottomSheetAddTask({super.key});

  @override
  State<BottomSheetAddTask> createState() => _BottomSheetAddTaskState();
}

class _BottomSheetAddTaskState extends State<BottomSheetAddTask> {
  late DateTime selectedDate;
  late int selectedPriority;
  var title = TextEditingController();
  var description = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedPriority = 1;
  }

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    description.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            "Add task",
            style: TextStyle(
              fontSize: 20,
              fontWeight: .w400,
              color: Color(0xff404147),
            ),
          ),
          SizedBox(height: 20),
          TextFormFieldWidget(
            hintText: "Enter task title",
            controller: title,
            validator: ValidatorApp.validateName,
          ),

          SizedBox(height: 10),

          TextFormFieldWidget(
            hintText: "Enter task description",
            controller: description,
            validator: ValidatorApp.validateName,
          ),

          SizedBox(height: 10),
          Row(
            children: [
              _IconAddTask(
                imagePath: AssetsIcons.dateIcon,
                onTap: () async {
                  selectedDate =
                      await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 60)),
                        initialDate: DateTime.now(),
                      ) ??
                      DateTime.now();
                },
              ),

              SizedBox(width: 12),

              _IconAddTask(
                imagePath: AssetsIcons.priorityIcon,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => SelectedTaskPriority(
                      callBackPriority: (priority) {
                        selectedPriority = priority;
                      },
                    ),
                  );
                },
              ),

              Spacer(),

              _IconAddTask(
                imagePath: AssetsIcons.sendIcon,
                onTap: () async {
                  AppTaskModel task = AppTaskModel(
                    title: title.text,
                    description: description.text,
                    date: selectedDate,
                    priority: selectedPriority,
                  );
                  await addTask(task);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> addTask(AppTaskModel task) async {
    AppDialog.showLoadingUi(context);
    final ResuletFirebase<AppTaskModel> resulte = await HomeFirebase.addTask(
      task,
    );
    log("query is done");
    if (!context.mounted) return;
    Navigator.of(context).pop();
    log("pop is done");
    switch (resulte) {
      case Success<AppTaskModel>():
        Navigator.of(context).pop();
      case Error<AppTaskModel>():
        AppDialog.showErrorUi(context: context, error: resulte.error);
    }
  }
}

class _IconAddTask extends StatelessWidget {
  _IconAddTask({super.key, required this.imagePath, this.onTap});
  String imagePath;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(imagePath, height: 24, width: 24, fit: BoxFit.contain),
    );
  }
}
