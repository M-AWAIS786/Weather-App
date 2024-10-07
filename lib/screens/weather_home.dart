import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_wise/constants/app_colors.dart';
import 'package:weather_wise/constants/app_strings.dart';
import 'package:weather_wise/constants/app_styles.dart';
import 'package:weather_wise/constants/weather_icons_maps.dart';
import 'package:weather_wise/state/currentweather_state.dart';
import 'package:weather_wise/state/toggleIcon_state.dart';
import 'package:weather_wise/widgets/skeleton_weatherhome_widget.dart';

class WeatherHome extends ConsumerWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ! currentweatherProvider state is watching
    final weatherData = ref.watch(currentWeatherProvider);
// ? weatherdata is filter with when conditon data,error,loading
    return weatherData.when(
      data: (weather) {
        return Scaffold(
          backgroundColor: AppColors.darkBlue.withOpacity(0.9),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  iconSize: 24,
                  icon: const Icon(Icons.menu_open),
                  color: AppColors.white,
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                const Icon(Icons.location_pin,
                    color: AppColors.lightBlue, size: 20),
                const SizedBox(width: 8),
                // ! region is coming from the current location
                Text(weather.location.name, style: AppStyles.h2),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: buildDayNightToggle(ref),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // topbarwidget(weather.location.name),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(AppString.screenHomeheading,
                        style: AppStyles.h1),
                    const SizedBox(
                        height: 16), // Space between the heading and the image
                    // 'assets/images/partly_cloudy.png'
                    // !image is here
                    Image.asset(
                      getWeatherImage(
                          weather.current.condition.text.toLowerCase()),
                      height: 200, // Adjust image height based on screen width
                      fit: BoxFit
                          .cover, // Keeps the image proportional within the circle
                    ),

                    Text('Its ${weather.current.condition.text}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35)),
                    // const SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      weather.current.tempC.toInt().toString(),
                                  children: const [
                                    TextSpan(
                                        text: '°',
                                        style: TextStyle(
                                            color: AppColors.lightBlue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 50))
                                  ],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50)),
                            ],
                          ),
                          // textScaler: const TextScaler.linear(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ! pass the weather tempC, WindKph, Humidity to the widget
                    buildWeatherInfoColumn(
                        Icons.air, 'Temp', '${weather.current.tempC}°'),
                    buildWeatherInfoColumn(Icons.thermostat, 'Wind',
                        '${weather.current.windKph}Km/h'),
                    buildWeatherInfoColumn(Icons.water_drop, 'Humidity',
                        '${weather.current.humidity}%'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString(), style: AppStyles.h2));
      },
      loading: () {
        return const SkeletonWeatherhome();
      },
    );
  }

  Column buildWeatherInfoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 35, color: AppColors.lightBlue),
        Text(label, style: AppStyles.h3),
        const SizedBox(height: 8),
        Text(value, style: AppStyles.subtitleText),
      ],
    );
  }

  Container buildDayNightToggle(WidgetRef ref) {
    // ! ref is coming from the provider
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Add shadow for depth
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // ! ref is coming from the provider
            buildToggleIcon(Icons.wb_sunny, 0, ref), // Day icon
            buildToggleIcon(Icons.nightlight_round, 1, ref), // Night icon
          ],
        ),
      ),
    );
  }

  Widget buildToggleIcon(IconData icon, int index, WidgetRef ref) {
    // ! ref watch selctedIcon Provider state
    final selectedIcon = ref.watch(selectedIconProvider);
    // ! ref is read current state and set the selectedIcon state
    return InkWell(
      onTap: () {
        ref.read(selectedIconProvider.notifier).state = index;
      },
      child: Container(
        // height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedIcon == index ? Colors.white : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 15,
            color: selectedIcon == index ? AppColors.lightBlue : AppColors.grey,
          ),
        ),
      ),
    );
  }
}
