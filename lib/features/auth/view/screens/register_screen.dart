import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/validator_app.dart';
import 'package:tasky/core/widgets/app_dialog.dart';
import 'package:tasky/features/auth/data/model/app_user.dart';
import 'package:tasky/features/auth/view/widgets/matreial_button_widget.dart';
import 'package:tasky/features/auth/view/widgets/state_user_auth.dart';
import 'package:tasky/features/auth/view/widgets/text_form_field_widget.dart';
import 'package:tasky/features/auth/view_model/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var name = TextEditingController();

  var email = TextEditingController();

  var phone = TextEditingController();

  var password = TextEditingController();

  var confirmPassword = TextEditingController();

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
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
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
          Navigator.of(context).pop();
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
                crossAxisAlignment: .start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff252525),
                    ),
                  ),
                  Text(
                    "by creating a free account.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff252525),
                    ),
                    textAlign: .center,
                  ),
                  SizedBox(height: 80),
                  Text(
                    "Full Name",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff252525),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormFieldWidget(
                    controller: name,
                    hintText: "Enter your Name",
                    validator: ValidatorApp.validateName,
                  ),
                  SizedBox(height: 12),
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
                  SizedBox(height: 12),
                  Text(
                    "Phone",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff252525),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormFieldWidget(
                    controller: phone,
                    hintText: "Enter your phone",
                    validator: ValidatorApp.validatePhoneNumber,
                  ),
                  SizedBox(height: 12),
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
                  SizedBox(height: 12),
                  Text(
                    "confirm Password",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff252525),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormFieldWidget(
                    controller: confirmPassword,
                    hintText: "Enter your Confirm Password",
                    validator: (value) => ValidatorApp.validateConfirmPassword(
                      value,
                      password.text,
                    ),
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
                label: "Register",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // calling function register
                    _cubit.register(
                      user: AppUser(
                        name: name.text,
                        phone: phone.text,
                        password: password.text,
                        email: email.text,
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 14),

              StateUserAuth(
                onTap: () {
                  Navigator.of(context).pop();
                },
                title: "Already a member ?",
                subTitle: 'Login now',
              ),
              SizedBox(height: 10),

              // Already a member? Login in
            ],
          ),
        ),
      ),
    );
  }
}


  // void register({required AppUser user, required BuildContext context}) async {
  //   AppDialog.showLoadingUi(context);

  //   ResuletFirebase<AppUser> resulte = await AppFirebaseAuth.register(
  //     user: user,
  //   );
  //   if (!context.mounted) return;
  //   Navigator.of(context).pop();

  //   switch (resulte) {
  //     case Success<AppUser>():
  //       Navigator.of(context).pop();
  //     case Error<AppUser>():
  //       AppDialog.showErrorUi(context: context, error: resulte.error);
  //   }
  // }
