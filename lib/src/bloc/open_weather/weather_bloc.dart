import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_first_app/src/models/openweather.dart';
import 'package:flutter_first_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

import '../blocs.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null), super(null);

  final WeatherRepository weatherRepository;
  final List<OpenWeather> weathers = [];

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final OpenWeather fetched =
            await weatherRepository.getWeather(event.city);
        int index =
            weathers.indexWhere((weather) => weather.name == fetched.name);
        if (weathers.isNotEmpty && index != -1) {
          print(index);
          weathers[index] = fetched;
        } else {
          weathers.add(fetched);
        }
        yield WeatherLoaded(weathers: weathers);
      } catch (error) {
        yield WeatherError(error: error);
      }
    }

    if (event is DeleteWeather) {
      yield WeatherLoading();
      try {
        weathers.remove(event.weather);
        if (weathers.isEmpty) {
          yield WeatherEmpty();
        } else {
          yield WeatherLoaded(weathers: weathers);
        }
      } catch (error) {
        yield WeatherError(error: error);
      }
    }
  }
}
