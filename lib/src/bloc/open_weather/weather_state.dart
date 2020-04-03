import 'package:equatable/equatable.dart';
import 'package:flutter_first_app/src/models/openweather.dart';
import 'package:meta/meta.dart';

class WeatherEmpty extends WeatherState {}

class WeatherError extends WeatherState {
  const WeatherError({@required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}

class WeatherLoaded extends WeatherState {
  const WeatherLoaded({@required this.weathers}) : assert(weathers != null);

  final List<OpenWeather> weathers;
  @override
  List<Object> get props => [weathers];
}

class WeatherLoading extends WeatherState {}

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}
