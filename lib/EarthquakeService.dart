import 'dart:convert';
import 'package:http/http.dart' as http;
import 'earthquake.dart'; // Earthquake modelini import et

class ApiService {
  static Future<List<Earthquake>> fetchEarthquakeData() async {
    final response = await http.get(Uri.parse('https://api.orhanaydogdu.com.tr/deprem/kandilli/live'));

    if (response.statusCode == 200) {
      // API'den gelen cevabı JSON formatında çözümleyip, bir listeye dönüştür
      var data = json.decode(response.body); // JSON çözümleme
      // Eğer veri bir liste ise (json -> List<dynamic>)
      return (data as List).map((earthquake) => Earthquake.fromJson(earthquake)).toList();
    } else {
      throw Exception('Failed to load earthquake data');
    }
  }
}
