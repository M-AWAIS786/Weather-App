import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_wise/services/api_services.dart';

final currentWeatherProvider = FutureProvider.autoDispose((ref) {
  return WeatherApi.getCurrentWeather();
});
