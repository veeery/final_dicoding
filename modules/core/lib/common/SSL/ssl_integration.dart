import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class IntegrationSSL {
  static Future<HttpClient> customHttpClient() async {

    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);

    try {
      final sslCert = await rootBundle.load('certificates/certificates.pem');
      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
      debugPrint('Certificate Cert Added!');
    } catch (e) {
      debugPrint('Certificate Cert Failed with Message: $e');
      rethrow;
    }

    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return httpClient;
  }

  static Future<http.Client> createLEClient() async {
    IOClient client = IOClient(await IntegrationSSL.customHttpClient());
    return client;
  }

}
