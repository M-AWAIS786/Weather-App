import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_wise/model/currentweather_model.dart';
import 'package:weather_wise/model/forecastweather_model.dart';
import 'package:weather_wise/services/geo_locator.dart';

class WeatherApi {
  static const String BASE_URL = "http://api.weatherapi.com/v1/";
  static const String key = "?key=Your API TOKEN";

  static double lat = 0.0;
  static double lon = 0.0;

  static Future<CurrentWeatherModel> getCurrentWeather() async {
    final location = await determinePosition();
    lat = location.latitude;
    lon = location.longitude;
    const midurl = "current.json";
    final endpoint = "&q=$lat,$lon";
    final url = BASE_URL + midurl + key + endpoint;

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data: ${response.body}");
    }
  }

  //? currently working on this function
  static Future<ForecastWeatherModel> getWeatherForecast() async {
    final location = await determinePosition(); // This will check permissions
    lat = location.latitude;
    lon = location.longitude;

    const midurl = "forecast.json";
    final endpoint = "&q=$lat,$lon&days=14"; // Example to get 7-day forecast
    final url = BASE_URL + midurl + key + endpoint;

    final response = await http.get(Uri.parse(url));
    // print("Forecast data: ${response.body}");

    if (response.statusCode == 200) {
      // print('sucess forecase');
      return ForecastWeatherModel.fromJson(
          jsonDecode(response.body)); // Parse the forecast data here
    } else {
      throw Exception("Failed to load forecast data: ${response.body}");
    }
  }
}
