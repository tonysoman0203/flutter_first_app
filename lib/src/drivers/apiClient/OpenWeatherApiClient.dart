import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_first_app/src/drivers/apiClient/BaseApiClient.dart';
import 'package:http/http.dart' as http;

import '../../models/openweather.dart';

class OpenWeatherApiClient extends BaseApiClient {
  OpenWeatherApiClient()
      : super(http.Client(), DotEnv().env['OPEN_WEATHER_API']);

  Future<OpenWeather> fetchOpenWeather(String location) async {
    var appId = DotEnv().env['API_OPEN_WEATHER_KEY'];

    var API = '${this.baseUrl}?q=$location&appId=$appId&units=metric';
    final response = await this.httpClient.post(API);

    if (response.statusCode == 200) {
      return OpenWeather.fromJson(json.decode(response.body));
    } else {
      throw HttpException(
          'Unexpected status code ${response.statusCode}:'
          ' ${response.reasonPhrase}',
          uri: Uri.parse(API));
    }
  }
}
