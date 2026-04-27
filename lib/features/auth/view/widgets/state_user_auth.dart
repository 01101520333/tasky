import 'package:flutter/material.dart';
import 'package:tasky/core/utils/colors_app.dart';

class StateUserAuth extends StatelessWidget {
  const StateUserAuth({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });
  final void Function()? onTap;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: .w500,
            color: Color(0xff000000),
          ),
          children: [
            TextSpan(
              text: subTitle,
              style: TextStyle(
                fontSize: 13,
                fontWeight: .w500,
                color: ColorsApp.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
