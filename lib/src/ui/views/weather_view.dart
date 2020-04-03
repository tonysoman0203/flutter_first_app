import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/src/bloc/blocs.dart';
import 'package:flutter_first_app/src/ui/views/weather_card.dart';

class WeatherView extends StatefulWidget {
  WeatherView({Key key}) : super(key: key);

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final formKey = GlobalKey<FormState>();
  final textEditController = TextEditingController();

  @override
  void dispose() {
    textEditController.dispose();
    super.dispose();
  }

  Future getOpenWeather() async {
    if (formKey.currentState.validate()) {
      String location = textEditController.text;
      BlocProvider.of<WeatherBloc>(context).add(FetchWeather(city: location));
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
          Center(
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is WeatherLoaded) {
                  var loaded = state.weathers;
                  return Center(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: loaded.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                            key: Key(loaded[index].name),
                            onDismissed: (direction) {
                              BlocProvider.of<WeatherBloc>(context)
                                  .add(DeleteWeather(weather: loaded[index]));
                            },
                            child: WeatherCard(
                                appWeather: loaded[index], index: index),
                          );
                        }),
                  );
                }
                if (state is WeatherError) {
                  var error = state.error;
                  return Text(
                    "Something went wrong! $error",
                    style: TextStyle(color: Colors.red),
                  );
                }
                return Center(
                  child: Text(
                    "No Weathers !",
                    style: TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
