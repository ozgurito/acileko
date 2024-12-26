import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';  // Dosya yolu için
import 'dart:io';  // Dosya işlemleri için

class ApiService {
  static const String _baseUrl = 'https://api.orhanaydogdu.com.tr/deprem/kandilli/live';

  // Deprem verilerini almak için
  static Future<List<dynamic>?> fetchEarthquakeData() async {
    try {
      final offlineData = await _loadOfflineData();
      if (offlineData != null) {
        return offlineData;
      }

      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // data['result']'in List<dynamic> türünde olduğuna emin olun
        if (data['result'] != null) {
          await _saveOfflineData(data['result']);
          return data['result'];
        }
        return null;
      }
      return null;
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }

  // Offline veriyi yükleme
  static Future<List<dynamic>?> _loadOfflineData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/earthquake_data.json');

    if (await file.exists()) {
      final contents = await file.readAsString();
      return json.decode(contents);
    }
    return null;
  }

  // Offline veriyi kaydetme
  static Future<void> _saveOfflineData(List<dynamic> data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/earthquake_data.json');
    await file.writeAsString(json.encode(data));
  }

  static getChatbotResponse(String userMessage) {}
}
