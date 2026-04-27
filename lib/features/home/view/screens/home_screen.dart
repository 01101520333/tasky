import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/assets_icons.dart';
import 'package:tasky/core/utils/assets_images.dart';
import 'package:tasky/core/utils/colors_app.dart';
import 'package:tasky/core/utils/validator_app.dart';
import 'package:tasky/core/widgets/text_form_field_widget.dart';
import 'package:tasky/features/auth/view/screens/log_in_screen.dart';
import 'package:tasky/features/home/view/widgets/bottom_sheet_add_task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "HomeScreen";

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

      body: EmptyHomeScreen(),

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
}

class EmptyHomeScreen extends StatelessWidget {
  const EmptyHomeScreen({super.key});

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
