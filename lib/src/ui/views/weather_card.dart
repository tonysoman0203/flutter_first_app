import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/src/models/openweather.dart';

class WeatherCard extends StatelessWidget {
  WeatherCard({this.appWeather, this.index});

  final OpenWeather appWeather;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(appWeather.weather[0].imageUrl),
              Text(appWeather.name),
              Text(appWeather.main.temp.toString() + '\u2103'),
              Text(appWeather.main.humidity.toString() + '%'),
              Text(DateTime.fromMillisecondsSinceEpoch(appWeather.dt * 1000)
                  .toString())
            ],
          ),
        ),
      ),
    );
  }
}
