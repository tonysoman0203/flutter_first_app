import 'package:http/http.dart' as http;

abstract class BaseApiClient {
  BaseApiClient(
    this.httpClient,
    this.baseUrl,
  ) : assert(httpClient != null && baseUrl != null);
  final http.Client httpClient;
  final String baseUrl;
}
