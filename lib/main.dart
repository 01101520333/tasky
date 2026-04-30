import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/features/auth/view/screens/log_in_screen.dart';
import 'package:tasky/features/auth/view/screens/register_screen.dart';
import 'package:tasky/features/home/view/screens/home_screen.dart';
import 'package:tasky/features/onboarding/screens/onboarding_screen.dart';
import 'package:tasky/features/onboarding/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser?.uid == null
          ? SplashScreen.routeName
          : HomeScreen.routeName,
      routes: {
        LogInScreen.routeName: (context) => LogInScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        // TaskScreen.routeName: (context) => TaskScreen(),
      },
    );
  }
}
