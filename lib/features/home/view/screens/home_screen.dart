import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/network/resulet_firebase.dart';
import 'package:tasky/core/utils/assets_icons.dart';
import 'package:tasky/features/auth/view/screens/log_in_screen.dart';
import 'package:tasky/features/home/data/firebase/home_firebase.dart';
import 'package:tasky/features/home/data/models/app_task_model.dart';
import 'package:tasky/features/home/view/widgets/bottom_sheet_add_task.dart';
import 'package:tasky/features/home/view/widgets/empty_home_section.dart';
import 'package:tasky/features/home/view/widgets/home_section.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AppTaskModel> tasks = [];
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  bool isDeleted = false;

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

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 20),

            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              height: 100,
              onDateChange: (date) {
                getTasks(date);
                selectedDate = date;
              },
            ),

            isLoading
                ? Center(child: CircularProgressIndicator())
                : (tasks.isEmpty
                      ? EmptyHomeSection()
                      : HomeSection(tasks: tasks)),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheetAddTask(
              notifyPerent: (dateTask) {
                final newSelectedDate = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                );
                final newDateTask = DateTime(
                  dateTask.year,
                  dateTask.month,
                  dateTask.day,
                );
                if (newDateTask == newSelectedDate) {
                  getTasks(selectedDate);
                }
              },
            ),
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
    setState(() {});
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
