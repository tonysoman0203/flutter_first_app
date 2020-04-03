import 'package:equatable/equatable.dart';
import 'package:flutter_first_app/src/models/openweather.dart';
import 'package:meta/meta.dart';

class DeleteWeather extends WeatherEvent {
  const DeleteWeather({@required this.weather}) : assert(weather != null);
  final OpenWeather weather;

  @override
  List<Object> get props => [weather];
}

class FetchWeather extends WeatherEvent {
  const FetchWeather({@required this.city}) : assert(city != null);
  final String city;

  @override
  List<Object> get props => [city];
}

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}
