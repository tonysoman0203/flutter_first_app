import 'dart:async';

import 'package:flutter_first_app/src/drivers/drivers.dart';
import 'package:flutter_first_app/src/models/openweather.dart';
import 'package:meta/meta.dart';

class WeatherRepository {
  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  final OpenWeatherApiClient weatherApiClient;

  Future<OpenWeather> getWeather(String location) async {
    final OpenWeather openWeather =
        await weatherApiClient.fetchOpenWeather(location);
    return openWeather;
  }
}
