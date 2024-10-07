import 'dart:developer';

Map<String, String> weatherImageMap = {
  'sunny': 'assets/images/sunny.png', // Sunny
  'partly cloudy': 'assets/images/partly_cloudy.png',
  'cloudy': 'assets/images/partly_cloudy.png', // Part
  'clear': 'assets/images/cloudy.png',
  'patchy rain possible': 'assets/images/rainy.png', // Rain
  'patchy light rain': 'assets/images/rainy.png',
  'light rain': 'assets/images/rainy.png',
  'moderate rain at times': 'assets/images/rainy.png',
  'moderate rain': 'assets/images/rainy.png',
  'heavy rain at times': 'assets/images/rainy.png',
  'heavy rain': 'assets/images/rainy.png',
  'light freezing rain': 'assets/images/rainy.png',
  'moderate or heavy freezing rain': 'assets/images/rainy.png',
  'light rain shower': 'assets/images/rainy.png',
  'thundery outbreaks possible':
      'assets/images/thunderstorm.png', // Thunderstorms
  'moderate or heavy rain shower': 'assets/images/thunderstorm.png',
  'torrential rain shower': 'assets/images/thunderstorm.png',
  '': 'assets/images/thunderstorm.png',
  'patchy freezing drizzle possible': 'assets/images/drizzle.png', // Drizzle
  'patchy light drizzle': 'assets/images/drizzle.png',
  'light drizzle': 'assets/images/drizzle.png',
  'freezing drizzle': 'assets/images/drizzle.png',
  'Heavy freezing drizzle': 'assets/images/drizzle.png',
  'Patchy snow possible': 'assets/images/snowy.png', // Snow
  'Blizzard': 'assets/images/blizzard.png', // Blizzard
  'Blowing snow': 'assets/images/snowy.png',
  'Patchy light snow': 'assets/images/snowy.png',
  'Light snow': 'assets/images/snowy.png',
  'Patchy moderate snow': 'assets/images/snowy.png',
  'Moderate snow': 'assets/images/snowy.png',
  'Patchy heavy snow': 'assets/images/snowy.png',
  'Heavy snow': 'assets/images/snowy.png',
  'Ice pellets': 'assets/images/snowy.png',
  'Light snow showers': 'assets/images/snowy.png',
  'Moderate or heavy snow showers': 'assets/images/snowy.png',
  'Patchy sleet possible': 'assets/images/sleet.png', // Sleet
  'Light sleet': 'assets/images/sleet.png',
  'Moderate or heavy sleet': 'assets/images/sleet.png',
  'Light sleet showers': 'assets/images/sleet.png',
  'Moderate or heavy sleet showers': 'assets/images/sleet.png',
  'Light showers of ice pellets': 'assets/images/sleet.png',
  'Moderate or heavy showers of ice pellets': 'assets/images/sleet.png',
  'Patchy light rain with thunder': 'assets/images/sleet.png',
  'Moderate or heavy rain with thunder':
      'assets/images/freezing_rain.png', // Freezing Rain
  'Patchy light snow with thunder': 'assets/images/freezing_rain.png',
  'Moderate or heavy snow with thunder': 'assets/images/freezing_rain.png',
  'Fog': 'assets/images/foggy.png', // Fog / Mist
  'Freezing fog': 'assets/images/foggy.png', // Fog / Mist
};

String getWeatherImage(String code) {
  log(code.toString());
  return weatherImageMap[code] ?? 'assets/images/foggy.png';
}
