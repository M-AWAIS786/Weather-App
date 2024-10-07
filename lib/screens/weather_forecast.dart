import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_wise/constants/app_colors.dart';
import 'package:weather_wise/constants/app_styles.dart';
import 'package:weather_wise/constants/weather_icons_maps.dart';
import 'package:weather_wise/state/forecastWeather_state.dart';
import 'package:weather_wise/widgets/skeleton_forecast_widget.dart';

// ! sirf images show krwaye hain isk bad day name or degree or mosam rehta
class WetherForCastScreen extends ConsumerWidget {
  WetherForCastScreen({super.key});
  DateTime now = DateTime.now();

  String formatteddate() {
    // DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM dd,yyyy').format(now);
    return formattedDate;
  }

  List<String> lowerFormattedDate() {
    List<String> date = [];
    for (var i = 0; i < 14; i++) {
      DateTime futuredata = now.add(Duration(days: i));
      String formattedDate = DateFormat('MMM,dd').format(futuredata);
      date.add(formattedDate);
    }
    return date;
  }

  List<String> formattedTime() {
    List<String> times = [];
    for (var i = 0; i < 14; i++) {
      DateTime futuredata = now.add(Duration(hours: i));
      String formattedT = DateFormat.jm().format(futuredata);
      times.add(formattedT);
    }
    return times;
  }

  List<String> daysName() {
    List<String> days = [];
    for (var i = 0; i < 14; i++) {
      DateTime date = now.add(Duration(days: i));
      String dayName = DateFormat('EEEE').format(date);
      days.add(dayName);
    }
    return days;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastW = ref.watch(forecastWeatherProvider);
    return forecastW.when(
      data: (forecastdata) {
        return SafeArea(
          child: Column(
            children: [
              const Center(
                child: Text('Forecast report', style: AppStyles.h1),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Today', style: AppStyles.largeSubtitle),
                    Text(formatteddate(), style: AppStyles.largeSubtitle),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: forecastdata.forecast.forecastday.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // !fdfdfdfdfdf
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 80,
                        //150
                        // width: 150,
                        decoration: BoxDecoration(
                          color: index == 0
                              ? AppColors.lightBlue
                              : Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // forecastdata.forecast
                            //         .forecastday[index].day.condition.code
                            // ! here is image
                            Image.asset(
                                getWeatherImage(forecastdata
                                    .forecast
                                    .forecastday[index]
                                    .hour[index]
                                    .condition
                                    .text
                                    .toString()
                                    .substring(5)
                                    .toLowerCase()),
                                height: 50),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // forecastdata.forecast.forecastday[index]
                              // .hour[index].time!
                              children: [
                                //! we show the time in upper listview
                                Text(formattedTime()[index],
                                    style:
                                        const TextStyle(color: Colors.white)),

                                // style: AppStyles.h3
                                const SizedBox(
                                  height: 8,
                                ),
                                // 32°C
                                Text(
                                    '${forecastdata.forecast.forecastday[index].hour[index].tempC}°C',
                                    style: AppStyles.h3),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Next forecast', style: AppStyles.largeSubtitle),
                    Icon(Icons.calendar_month_outlined, color: AppColors.white),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: forecastdata.forecast.forecastday.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: Container(
                          height: 100,
                          // width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(daysName()[index],
                                        style: AppStyles.h3),
                                    Text(lowerFormattedDate()[index],
                                        style: AppStyles.largeSubtitle),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      // 32°C'
                                      '${forecastdata.forecast.forecastday[index].day.avgtempC}°',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.white)),
                                  Text(
                                      textAlign: TextAlign.center,
                                      forecastdata.forecast.forecastday[index]
                                          .day.condition.text
                                          .toString()
                                          .substring(5),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                ],
                              )),
                              Expanded(
                                  // ! here is image
                                  child: Image.asset(
                                      getWeatherImage(forecastdata.forecast
                                          .forecastday[index].day.condition.text
                                          .toString()
                                          .substring(5)
                                          .toLowerCase()),
                                      height: 80)),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        // print(stackTrace);
        return const Center(child: forecastSketch());
      },
      loading: () {
        return const Center(child: forecastSketch());
      },
    );
  }
}

// class _skeleton extends StatelessWidget {
//   _skeleton({
//     super.key,
//     this.height,
//     this.width,
//   });
//   final double? height, width;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.grey[800],
//         borderRadius: BorderRadius.circular(16),
//       ),
//     );
//   }
// }
