import 'package:core/common/SSL/ssl_integration.dart';
import 'package:http/http.dart' as http;

class SSLPinning {
  static http.Client? _clientInstance;

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<http.Client> get _instance async => _clientInstance ??= await IntegrationSSL.createLEClient();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}
