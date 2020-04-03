import 'package:bloc/bloc.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_first_app/src/bloc/blocs.dart';
import 'package:flutter_first_app/src/delegate/delegate.dart';
import 'package:flutter_first_app/src/drivers/apiClient/OpenWeatherApiClient.dart';
import 'package:flutter_first_app/src/repositories/repositories.dart';
import 'package:flutter_first_app/src/ui/views/my_map.dart';
import 'package:flutter_first_app/src/ui/views/weather_view.dart';

Future main() async {
  await DotEnv().load('.env');

  BlocSupervisor.delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository =
      WeatherRepository(weatherApiClient: OpenWeatherApiClient());

  runApp(MyApp(weatherRepository: weatherRepository));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => _buildTheme(brightness),
      themedWidgetBuilder: (context, theme) => BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: MaterialApp(
          title: 'Startup Name Generator',
          theme: theme,
          home: RandomWords(),
        ),
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    return brightness == Brightness.dark
        ? ThemeData.dark().copyWith(
            textTheme: ThemeData.dark().textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                  fontFamily: 'Basier',
                ),
            backgroundColor: Colors.black)
        : ThemeData.light().copyWith(
            textTheme: ThemeData.light().textTheme.apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                  fontFamily: 'Basier',
                ),
            backgroundColor: Colors.white);
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 16);
  final Set<WordPair> saved = Set<WordPair>();

  Widget buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext buildContext, int i) {
        if (i.isOdd) {
          return Divider();
        }

        final int index = i ~/ 2;
        if (index >= suggestions.length) {
          suggestions.addAll(generateWordPairs().take(10));
        }
        return buildRow(suggestions[index]);
      },
    );
  }

  Widget buildRow(WordPair pair) {
    final bool isAlreadySaved = saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        isAlreadySaved ? Icons.favorite : Icons.favorite_border,
        color: isAlreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (isAlreadySaved) {
            saved.remove(pair);
          } else {
            saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: pushSaved,
          ),
          IconButton(
            icon: Icon(Icons.brightness_2),
            onPressed: changeDarkMode,
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: navigateToMapView,
          ),
          IconButton(
            icon: Icon(Icons.wb_cloudy),
            onPressed: navigateToWeatherView,
          )
        ],
      ),
      body: buildSuggestions(),
    );
  }

  void changeDarkMode() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void navigateToMapView() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return MyMap();
    }));
  }

  void navigateToWeatherView() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return WeatherView();
    }));
  }

  void pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = saved.map(
        (WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );
      final List<Widget> divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text("Saved Suggestions"),
        ),
        body: ListView(children: divided),
      );
    }));
  }
}
