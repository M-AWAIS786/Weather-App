import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_wise/constants/app_colors.dart';
import 'package:weather_wise/constants/app_styles.dart';
import 'package:weather_wise/onboarding/onboardingItems.dart';
import 'package:weather_wise/screens/weather_structure.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue.withOpacity(0.9),
      bottomSheet: Container(
        color: Colors.grey[900],
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () =>
                        pageController.jumpToPage(controller.items.length - 1),
                    child: Text(
                      'Skip',
                      style: AppStyles.h2,
                    ),
                  ),

                  //indicator
                  SmoothPageIndicator(
                      controller: pageController,
                      count: controller.items.length,
                      onDotClicked: (index) => pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          ),
                      effect: WormEffect(
                        dotColor: Colors.white,
                        dotHeight: 12,
                        dotWidth: 13,
                        activeDotColor: AppColors.lightBlue,
                      )),
                  TextButton(
                    onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    ),
                    child: Text('Next', style: AppStyles.h2),
                  ),
                ],
              ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(controller.items[index].title, style: AppStyles.h1),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(controller.items[index].description,
                      textAlign: TextAlign.center,
                      style: AppStyles.subtitleText),
                ],
              );
            },
          )),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.lightBlue,
      ),
      width: double.infinity,
      height: 55,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: TextButton(
            onPressed: () async {
              final pres = await SharedPreferences.getInstance();
              pres.setBool("onboarding", true);

              //After we press get started button this onboarding value become true
              // same key
              if (!mounted) return;
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WeatherStructure()));
            },
            child: const Text(
              "Get started",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
