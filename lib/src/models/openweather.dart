import 'package:json_annotation/json_annotation.dart';

part 'openweather.g.dart';

@JsonSerializable()
class OpenWeather {
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

  Map<String, dynamic> toJson() => _$OpenWeatherToJson(this);
}

@JsonSerializable()
class System {
  System(
      {this.type,
      this.id,
      this.message,
      this.sunrise,
      this.sunset,
      this.country});

  factory System.fromJson(Map<String, dynamic> json) => _$SystemFromJson(json);

  final int type, id, message, sunrise, sunset;
  final String country;

  Map<String, dynamic> toJson() => _$SystemToJson(this);
}

@JsonSerializable()
class Main {
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

  dynamic temp;
  dynamic pressure;
  dynamic humidity;
  dynamic tempMin;
  dynamic tempMax;
  dynamic feelsLike;
  dynamic seaLevel;
  dynamic grndLevel;

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Clouds {
  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  final int all;

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Wind {
  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  final double speed;
  final int deg;

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class Weather {
  Weather({this.id, this.main, this.desc, this.imageUrl});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        id: json['id'],
        main: json['main'],
        desc: json['description'],
        imageUrl: 'http://openweathermap.org/img/w/${json['icon']}.png');
  }

  final int id;
  final String desc;
  final String main;
  final String imageUrl;

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Coord {
  Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  final double lat, lon;

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}
