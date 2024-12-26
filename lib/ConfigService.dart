import 'dart:convert';  // json.decode için gerekli
import 'package:flutter/services.dart';  // rootBundle için

class ConfigService {
  // JSON dosyasını okuyarak konfigürasyon ayarlarını döndürür
  static Future<Map<String, dynamic>> loadConfig() async {
    final configString = await rootBundle.loadString('assets/config.json');
    final configMap = json.decode(configString);  // JSON verisini çözümle
    return configMap;
  }
}
