import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/validator_app.dart';
import 'package:tasky/core/widgets/app_dialog.dart';
import 'package:tasky/features/auth/view/screens/register_screen.dart';
import 'package:tasky/features/auth/view/widgets/matreial_button_widget.dart';
import 'package:tasky/features/auth/view/widgets/state_user_auth.dart';
import 'package:tasky/features/auth/view/widgets/text_form_field_widget.dart';
import 'package:tasky/features/auth/view_model/auth_cubit.dart';
import 'package:tasky/features/home/screens/home_screen.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});
  static const String routeName = "LogInScreen";

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var email = TextEditingController();

  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  late final AuthCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = AuthCubit();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is AuthLoading) {
          AppDialog.showLoadingUi(context);
        }

        if (state is AuthSuccess) {
          // if (!context.mounted) return;
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }

        if (state is AuthError) {
          // if (!context.mounted) return;
          Navigator.of(context).pop();
          AppDialog.showErrorUi(context: context, error: state.error);
        }
      },
      child: Scaffold(
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
                    _cubit.login(email: email.text, password: password.text);
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
      ),
    );
  }
}



// void login({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     AppDialog.showLoadingUi(context);
//     ResuletFirebase<bool> resulte = await AppFirebaseAuth.logIn(
//       email: email,
//       password: password,
//     );
//     if (!context.mounted) return;
//     Navigator.of(context).pop();
//     switch (resulte) {
//       case Success<bool>():
//         Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
//       case Error<bool>():
//         AppDialog.showErrorUi(context: context, error: resulte.error);
//     }
//   }