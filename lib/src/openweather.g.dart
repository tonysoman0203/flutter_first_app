// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openweather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenWeather _$OpenWeatherFromJson(Map<String, dynamic> json) {
  return OpenWeather(
    coord: json['coord'] == null
        ? null
        : Coord.fromJson(json['coord'] as Map<String, dynamic>),
    weather: (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    base: json['base'] as String,
    visibility: json['visibility'] as int,
    main: json['main'] == null
        ? null
        : Main.fromJson(json['main'] as Map<String, dynamic>),
    wind: json['wind'] == null
        ? null
        : Wind.fromJson(json['wind'] as Map<String, dynamic>),
    clouds: json['clouds'] == null
        ? null
        : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
    dt: json['dt'] as int,
    sys: json['sys'] == null
        ? null
        : System.fromJson(json['sys'] as Map<String, dynamic>),
    timezone: json['timezone'] as int,
    id: json['id'] as int,
    name: json['name'] as String,
    cod: json['cod'] as int,
  );
}

Map<String, dynamic> _$OpenWeatherToJson(OpenWeather instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'weather': instance.weather,
      'base': instance.base,
      'visibility': instance.visibility,
      'main': instance.main,
      'wind': instance.wind,
      'clouds': instance.clouds,
      'dt': instance.dt,
      'sys': instance.sys,
      'timezone': instance.timezone,
      'id': instance.id,
      'name': instance.name,
      'cod': instance.cod,
    };

System _$SystemFromJson(Map<String, dynamic> json) {
  return System(
    type: json['type'] as int,
    id: json['id'] as int,
    message: json['message'] as int,
    sunrise: json['sunrise'] as int,
    sunset: json['sunset'] as int,
    country: json['country'] as String,
  );
}

Map<String, dynamic> _$SystemToJson(System instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'message': instance.message,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'country': instance.country,
    };

Main _$MainFromJson(Map<String, dynamic> json) {
  return Main(
    temp: json['temp'],
    pressure: json['pressure'],
    humidity: json['humidity'],
    tempMin: json['tempMin'],
    tempMax: json['tempMax'],
    feelsLike: json['feelsLike'],
    grndLevel: json['grndLevel'],
    seaLevel: json['seaLevel'],
  );
}

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'feelsLike': instance.feelsLike,
      'seaLevel': instance.seaLevel,
      'grndLevel': instance.grndLevel,
    };

Clouds _$CloudsFromJson(Map<String, dynamic> json) {
  return Clouds(
    all: json['all'] as int,
  );
}

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
      'all': instance.all,
    };

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind(
    speed: (json['speed'] as num)?.toDouble(),
    deg: json['deg'] as int,
  );
}

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    id: json['id'] as int,
    main: json['main'] as String,
    desc: json['desc'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'desc': instance.desc,
      'main': instance.main,
      'imageUrl': instance.imageUrl,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) {
  return Coord(
    lat: (json['lat'] as num)?.toDouble(),
    lon: (json['lon'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };
