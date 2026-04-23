import 'package:flutter/material.dart';
import 'package:tasky/core/utils/colors_app.dart';

class MaterialButtonWidget extends StatelessWidget {
  MaterialButtonWidget({super.key, required this.label, this.onPressed});
  String label;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: ColorsApp.primaryColor,
      height: 48,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xffffffff),
        ),
      ),
    );
  }
}
