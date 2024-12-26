import 'dart:convert';  // JSON verisini çözümlemek için gerekli
import 'package:flutter/services.dart';  // rootBundle için

class ConfigService {
  // JSON dosyasını okuyarak konfigürasyon ayarlarını döndürür
  static Future<Map<String, dynamic>> loadConfig() async {
    try {
      // assets/config.json dosyasını yükle
      final configString = await rootBundle.loadString('assets/config.json');

      // JSON verisini çözümle
      final configMap = json.decode(configString);

      return configMap;
    } catch (e) {
      // Hata durumunda hata mesajı döndür
      print("Config dosyası okunurken hata oluştu: $e");
      throw Exception("Config dosyası okunamadı.");
    }
  }
}
