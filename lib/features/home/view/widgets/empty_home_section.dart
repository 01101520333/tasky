import 'package:flutter/material.dart';
import 'package:tasky/core/utils/assets_images.dart';
import 'package:tasky/core/utils/colors_app.dart';

class EmptyHomeSection extends StatelessWidget {
  const EmptyHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: .min,
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
