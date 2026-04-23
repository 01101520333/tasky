import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    this.controller,
    required this.hintText,
    this.onTap,
    this.validator,
  });
  final TextEditingController? controller;
  final String hintText;
  final void Function()? onTap;
  String? Function(String?)? validator;

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
          borderSide: BorderSide(color: Color(0xffFF3951)),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
