import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky/core/utils/assets_images.dart';
import 'package:tasky/core/utils/colors_app.dart';
import 'package:tasky/features/auth/view/screens/log_in_screen.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});
  static const String routeName = "OnboardingScreen";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingData> onboardingData = dataOnboarding();

  int index = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return CustonAnimatedWidget(
                    index: index,
                    delay: index,
                    child: Image.asset(onboardingData[index].imagePath),
                  );
                },
              ),
            ),

            SizedBox(height: 35),

            SmoothPageIndicator(
              controller: controller,
              count: onboardingData.length,
              effect: ExpandingDotsEffect(
                spacing: 10,
                radius: 10,
                dotWidth: 15,
                dotHeight: 5,
                activeDotColor: ColorsApp.primaryColor,
              ),
            ),

            SizedBox(height: 50),

            CustonAnimatedWidget(
              index: index,
              delay: (index + 1) * 100,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      onboardingData[index].title,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: .bold,
                        color: ColorsApp.textColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      onboardingData[index].descrabtion,
                      textAlign: .center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w500,
                        color: ColorsApp.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 107),

            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Align(
                alignment: .centerRight,
                child: MaterialButton(
                  onPressed: () {
                    if (index < onboardingData.length - 1) {
                      controller.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                    } else {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(LogInScreen.routeName);
                    }
                  },
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  color: ColorsApp.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: .circular(10)),
                  child: Text(
                    index < onboardingData.length - 1 ? "Next" : "Get Started",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .w400,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String descrabtion;
  final String imagePath;

  OnboardingData({
    required this.title,
    required this.descrabtion,
    required this.imagePath,
  });
}

List<OnboardingData> dataOnboarding() {
  return [
    OnboardingData(
      title: "Manage your tasks",
      descrabtion:
          "You can easily manage all of your daily tasks in DoMe for free",
      imagePath: AssetsImages.taskManagementImage,
    ),

    OnboardingData(
      title: "Create daily routine",
      descrabtion:
          "In Tasky  you can create your personalized routine to stay productive",
      imagePath: AssetsImages.timeManagementImage,
    ),

    OnboardingData(
      title: "Orgonaize your tasks",
      descrabtion:
          "You can organize your daily tasks by adding your tasks into separate categories",
      imagePath: AssetsImages.calenderImage,
    ),
  ];
}

class CustonAnimatedWidget extends StatelessWidget {
  const CustonAnimatedWidget({
    super.key,
    required this.index,
    required this.delay,
    required this.child,
  });
  final int index;
  final int delay;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }

    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }
}
