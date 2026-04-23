import 'package:flutter/material.dart';
import 'package:tasky/core/utils/colors_app.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.controller,
    required this.hintText,
    this.onTap,
    this.validator,
  });
  final TextEditingController? controller;
  final String hintText;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      validator: validator,

      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffEFEFEF),
        hint: Text(hintText),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsApp.primaryColor),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
