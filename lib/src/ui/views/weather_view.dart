import 'package:flutter/material.dart';
import 'package:flutter_first_app/src/openweather.dart';
import 'package:flutter_first_app/src/ui/views/weather_card.dart';

class WeatherView extends StatefulWidget {
  WeatherView({Key key}) : super(key: key);

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final formKey = GlobalKey<FormState>();
  final textEditController = TextEditingController();
  final List<OpenWeather> openWeathers = List();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditController.dispose();
    super.dispose();
  }

  Future getOpenWeather() async {
    setState(() {
      isLoading = true;
    });

    if (formKey.currentState.validate()) {
      String location = textEditController.text;
      var openWeather = await fetchOpenWeather(location);
      setState(() {
        openWeathers.add(openWeather);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather'),
        ),
        body: Column(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Location"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter location name';
                        }
                        return null;
                      },
                      controller: textEditController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RaisedButton(
                      onPressed: getOpenWeather,
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: openWeathers.isEmpty
                        ? Text(
                            "No Weathers !",
                            style: TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          )
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: openWeathers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                key: Key(openWeathers[index].name),
                                onDismissed: (direction) {
                                  setState(() {
                                    openWeathers.removeAt(index);
                                  });
                                },
                                child: WeatherCard(
                                    appWeather: openWeathers[index],
                                    index: index),
                              );
                            }),
                  ),
          ],
        ));
  }
}
