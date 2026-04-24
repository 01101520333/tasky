import 'package:flutter/material.dart';
import 'package:tasky/core/utils/validator_app.dart';
import 'package:tasky/core/widgets/app_dialog.dart';
import 'package:tasky/features/auth/data/firebase/app_firebase_auth.dart';
import 'package:tasky/features/auth/screens/register_screen.dart';
import 'package:tasky/features/auth/widgets/matreial_button_widget.dart';
import 'package:tasky/features/auth/widgets/state_user_auth.dart';
import 'package:tasky/features/auth/widgets/text_form_field_widget.dart';
import 'package:tasky/features/home/screens/home_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  static const String routeName = "LogInScreen";
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 120),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff252525),
                  ),
                ),
                Text(
                  "sign in to access your account",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff252525),
                  ),
                  textAlign: .center,
                ),

                SizedBox(height: 80),

                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff252525),
                  ),
                ),
                SizedBox(height: 5),
                TextFormFieldWidget(
                  controller: email,
                  hintText: "Enter your email",
                  validator: ValidatorApp.validateEmail,
                ),

                SizedBox(height: 30),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff252525),
                  ),
                ),
                SizedBox(height: 5),
                TextFormFieldWidget(
                  controller: password,
                  hintText: "Enter your Password",
                  validator: ValidatorApp.validatePassword,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: .min,
          children: [
            MaterialButtonWidget(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // call firebase auth
                  login(
                    email: email.text,
                    password: password.text,
                    context: context,
                  );
                }
              },
              label: "Login",
            ),
            SizedBox(height: 14),
            StateUserAuth(
              onTap: () {
                Navigator.of(context).pushNamed(RegisterScreen.routeName);
              },
              title: "New member ?",
              subTitle: 'Register now',
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    AppDialog.showLoadingUi(context);
    bool resulte = await AppFirebaseAuth.logIn(
      email: email,
      password: password,
    );
    if (!context.mounted) return;
    Navigator.of(context).pop();
    if (resulte) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      AppDialog.showErrorUi(
        context: context,
        error: "from firebase Auth , please try agine",
      );
    }
  }
}
