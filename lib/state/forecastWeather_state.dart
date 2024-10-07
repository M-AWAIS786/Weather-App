import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_wise/services/api_services.dart';

final forecastWeatherProvider = FutureProvider.autoDispose(
  (ref) {
    return WeatherApi.getWeatherForecast();
  },
);
