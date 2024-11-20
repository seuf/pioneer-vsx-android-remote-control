import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<Map<String, String>>> loadConfig() async {
  final String response = await rootBundle.loadString('assets/config.json');
  // final String url = json.decode(response)['ip'] as String;
  // final String endpoint = json.decode(response)['endpoint'] as String;
  final List<dynamic> data = json.decode(response)['buttons'];
  return data.map((item) => {
        'name': item['name'] as String,
        'endpoint': item['endpoint'] as String,
        'icon': item['icon'] as String,
      }).toList().cast<Map<String, String>>();
}