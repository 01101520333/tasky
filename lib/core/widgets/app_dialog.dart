import 'package:flutter/material.dart';
import 'package:tasky/core/utils/colors_app.dart';

abstract class AppDialog {
  static void showLoadingUi(BuildContext context) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) => PopScope(
        // canPop: false,
        child: AlertDialog(
          backgroundColor: ColorsApp.backgroundColor,
          content: SizedBox(
            height: 40,
            width: 40,
            child: Center(
              child: Row(
                spacing: 30,
                mainAxisAlignment: .center,
                children: [
                  CircularProgressIndicator(color: ColorsApp.primaryColor),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .w400,
                      color: ColorsApp.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showErrorUi({
    required BuildContext context,
    required String error,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsApp.backgroundColor,
        title: Text("Error"),
        content: Text(
          error,
          style: TextStyle(fontSize: 16, fontWeight: .w400, color: Colors.red),
        ),
      ),
    );
  }
}
