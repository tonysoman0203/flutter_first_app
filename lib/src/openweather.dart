import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'openweather.g.dart';

@JsonSerializable()
class OpenWeather {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final int visibility;
  final Main main;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final System sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  OpenWeather(
      {this.coord,
      this.weather,
      this.base,
      this.visibility,
      this.main,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  factory OpenWeather.fromJson(Map<String, dynamic> json) =>
      _$OpenWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$OpenWeatherToJson(this);
}

@JsonSerializable()
class System {
  final int type, id, message, sunrise, sunset;
  final String country;

  System(
      {this.type,
      this.id,
      this.message,
      this.sunrise,
      this.sunset,
      this.country});

  factory System.fromJson(Map<String, dynamic> json) => _$SystemFromJson(json);

  Map<String, dynamic> toJson() => _$SystemToJson(this);
}

@JsonSerializable()
class Main {
  dynamic temp;
  dynamic pressure;
  dynamic humidity;
  dynamic tempMin;
  dynamic tempMax;
  dynamic feelsLike;
  dynamic seaLevel;
  dynamic grndLevel;

  Main(
      {this.temp,
      this.pressure,
      this.humidity,
      this.tempMin,
      this.tempMax,
      this.feelsLike,
      this.grndLevel,
      this.seaLevel});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Clouds {
  final int all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Wind {
  final double speed;
  final int deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class Weather {
  final int id;
  final String desc;
  final String main;
  final String imageUrl;

  Weather({this.id, this.main, this.desc, this.imageUrl});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        id: json['id'],
        main: json['main'],
        desc: json['description'],
        imageUrl: 'http://openweathermap.org/img/w/${json['icon']}.png');
  }

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Coord {
  final double lat, lon;

  Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

Future<OpenWeather> fetchOpenWeather(String location) async {
  var openWeatherApiDomain = DotEnv().env['OPEN_WEATHER_API'];

  var map = new Map<String, dynamic>();
  map["q"] = jsonEncode(location);
  map["units"] = "metrics";

  var appId = DotEnv().env['API_OPEN_WEATHER_KEY'];

  var API = "${openWeatherApiDomain}?q=${location}&appId=${appId}&units=metric";
  final response = await http.post(API);

  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return OpenWeather.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(API));
  }
}
