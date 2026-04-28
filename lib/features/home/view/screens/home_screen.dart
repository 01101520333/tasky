import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/network/resulet_firebase.dart';
import 'package:tasky/core/utils/assets_icons.dart';
import 'package:tasky/core/utils/assets_images.dart';
import 'package:tasky/core/utils/colors_app.dart';
import 'package:tasky/core/utils/validator_app.dart';
import 'package:tasky/core/widgets/text_form_field_widget.dart';
import 'package:tasky/features/auth/view/screens/log_in_screen.dart';
import 'package:tasky/features/home/data/firebase/home_firebase.dart';
import 'package:tasky/features/home/data/models/app_task_model.dart';
import 'package:tasky/features/home/view/widgets/bottom_sheet_add_task.dart';
import 'package:tasky/features/home/view_model/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AppTaskModel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getTasks(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(AssetsIcons.logoIcon, width: 90),

            Spacer(),

            Image.asset(AssetsIcons.logoutIcon, height: 30, width: 30),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                if (!context.mounted) return;

                Navigator.of(
                  context,
                ).pushReplacementNamed(LogInScreen.routeName);
              },
              child: Text(
                "Log out",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: .w400,
                  color: Color(0xffFF4949),
                ),
              ),
            ),
          ],
        ),
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : (tasks.isEmpty
                ? EmptyHomeSection()
                : HomeSection(
                    tasks: tasks,
                    onDateChange: (date) {
                      getTasks(date);
                    },
                  )),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheetAddTask(),
          );
        },
        backgroundColor: Color(0xff24252C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(30),
        ),
        child: Icon(Icons.add, size: 30, color: Color(0xff5F33E1)),
      ),
    );
  }

  Future<void> getTasks(DateTime date) async {
    isLoading = true;
    final resulte = await HomeFirebase.getTasks(date);
    switch (resulte) {
      case Success<List<AppTaskModel>>():
        isLoading = false;
        tasks = resulte.data;
      case Error<List<AppTaskModel>>():
        isLoading = false;
        tasks = [];
    }
    setState(() {});
  }
}

class EmptyHomeSection extends StatelessWidget {
  const EmptyHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(height: 100),
          Image.asset(AssetsImages.emptyScreenImage),
          SizedBox(height: 5),
          Text(
            "What do you want to do today?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: .w400,
              color: ColorsApp.textColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Tap + to add your tasks",
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w400,
              color: Color(0xff404147),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeSection extends StatelessWidget {
  HomeSection({super.key, required this.tasks, this.onDateChange});
  List<AppTaskModel> tasks;
  void Function(DateTime date)? onDateChange;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.black,
          selectedTextColor: Colors.white,
          height: 100,
          onDateChange: onDateChange,
        ),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: tasks.length,
            itemBuilder: (context, index) => ItemTaskWidget(task: tasks[index]),
          ),
        ),
      ],
    );
  }
}

class ItemTaskWidget extends StatelessWidget {
  ItemTaskWidget({super.key, required this.task});
  AppTaskModel task;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff5F33E1),
      child: ListTile(
        leading: Text(
          task.priority.toString(),
          style: TextStyle(color: Colors.white),
        ), // Text
        trailing: Text(
          task.date.toString(),
          style: TextStyle(color: Colors.white),
        ), // Text
        title: Text(task.title ?? "", style: TextStyle(color: Colors.white)),
        subtitle: Text(
          task.description ?? "",
          style: TextStyle(color: Colors.white),
        ), // Text
      ), // ListTile
    ); // Card
  }
}
