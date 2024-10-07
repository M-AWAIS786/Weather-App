import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_wise/onboarding/onboardingView.dart';
import 'package:weather_wise/screens/weather_structure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;

  runApp(ProviderScope(
      child: MyApp(
    onboarding: onboarding,
  )));
}
  // flutter build apk --split-per-abi
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.onboarding});
  final bool onboarding;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Wise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
      ),
      // home: const WeatherStructure(),
      home: onboarding ? WeatherStructure() : OnboardingView(),
    );
  }
}
