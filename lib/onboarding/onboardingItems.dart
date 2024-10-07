import 'package:weather_wise/onboarding/onboardingModel.dart';

class OnboardingItems {
  List<OnboardingInfoModel> items = [
    OnboardingInfoModel(
        title: 'Welcome to WeatherWise!', //sunny day
        description:
            'Stay updated with real-time weather forecasts and alerts tailored to your location. Never be caught off guard by sudden weather changes!',
        image: 'assets/images/drizzle.png'),
    OnboardingInfoModel(
        title: 'Accurate Forecasts', //rain cloud
        description:
            'Get precise weather updates including temperature, humidity, and wind speed. Plan your activities with confidence, rain or shine!',
        image: 'assets/images/thunderstorm.png'),
    OnboardingInfoModel(
        title: 'Interactive Maps', //illustration of a weather map
        description:
            'Explore interactive maps that provide detailed weather conditions in your area and around the globe. Track storms, view radar, and more!',
        image: 'assets/images/map_w.png'),
    OnboardingInfoModel(
      image: "assets/images/user_interface.png",
      title: "Easy to Use",
      description:
          "Our user-friendly interface makes it easy to access the information you need at a glance. Get started today and take control of your weather experience!",
    )
  ];
}
