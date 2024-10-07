import 'package:flutter/material.dart';
import 'package:weather_wise/constants/app_colors.dart';
import 'package:weather_wise/screens/weather_forecast.dart';
import 'package:weather_wise/screens/weather_home.dart';
import 'package:weather_wise/screens/weather_search.dart';

class WeatherStructure extends StatefulWidget {
  const WeatherStructure({super.key});

  @override
  State<WeatherStructure> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherStructure> {
  int currentIndex = 0;
  final List<Widget> _screens = [
    WeatherHome(),
    WeatherSearchScreen(),
    WetherForCastScreen(),
    WeatherSearchScreen(),
    // const WeatherSearchScreen(),
    // const WeatherSearchScreen(),
    // const WeatherSearchScreen(),
    // const WeatherSearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue.withOpacity(0.9),
      body: _screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25),
        child: Container(
          // height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                selectedIconTheme:
                    const IconThemeData(color: AppColors.lightBlue),
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: currentIndex,
                iconSize: 30,
                type: BottomNavigationBarType.fixed,
                unselectedIconTheme: const IconThemeData(color: Colors.white),
                // Adjust the height of the BottomNavigationBar
                selectedLabelStyle: const TextStyle(
                    height: 0), // Hides labels and adjusts space
                unselectedLabelStyle: const TextStyle(height: 0), //
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons
                        .home), // Only need one icon, color handled by the BottomNavigationBar
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.auto_awesome_sharp),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: '',
                  ),
                ],
                // fixedColor: AppColors.lightBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
