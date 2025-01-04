import 'dart:convert';  // json.decode için gerekli
import 'package:http/http.dart' as http;  // HTTP istekleri için
//BU CLASS KULLANILMIYOR//
import 'package:flutter/material.dart';

class ApiService {
  // Kandilli API'si
  static const String _kandilliBaseUrl = 'https://api.koeri.boun.edu.tr/deprem/data/get'; // Kandilli API'si endpoint

  // OpenAI API'si
  static const String _openAiBaseUrl = 'https://api.openai.com/v1/chat/completions';
  static const String _openAiApiKey = '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';  // OpenAI API anahtarınızı buraya ekledik

  // Deprem verilerini almak için metod (Kandilli API)
  static Future<List<dynamic>?> fetchEarthquakeData() async {
    try {
      final response = await http.get(Uri.parse(_kandilliBaseUrl)); // GET isteği gönderiyoruz

      if (response.statusCode == 200) {
        var data = json.decode(response.body); // API'den gelen JSON verisini çözümlüyoruz
        return data['result']; // API'den gelen veriden 'result' kısmını alıyoruz
      } else {
        print("API çağrısı başarısız oldu: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("API çağrısı sırasında hata: $e");
      return null;
    }
  }

  // Chatbot yanıtını almak için metod (OpenAI GPT-4)
  static Future<String> getChatbotResponse(String userInput) async {
    try {
      final response = await http.post(
        Uri.parse(_openAiBaseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_openAiApiKey',  // OpenAI API anahtarını burada kullanıyoruz
        },
        body: json.encode({
          'model': 'gpt-4',  // GPT-4 modelini kullanıyoruz
          'messages': [
            {'role': 'user', 'content': userInput}  // Kullanıcıdan gelen mesajı gönderiyoruz
          ]
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['choices'][0]['message']['content'].toString().trim();
      } else {
        throw Exception('API request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print("Chatbot API çağrısı sırasında hata: $e");
      return 'Hata oluştu, lütfen tekrar deneyin.';
    }
  }

  // Deprem tahminini almak için metod
  static Future<double> getPrediction(int year, int timeslot, int floor) async {
    try {
      // Burada tahmin API'sine istek gönderiyoruz
      final response = await http.post(
        Uri.parse('https://api.yourpredictionapi.com/predict'),  // Örnek URL, kendi tahmin API'nizi kullanın
        headers: {
          'Content-Type': 'application/json',
          // Eğer API anahtarınız varsa, Authorization header ekleyebilirsiniz
        },
        body: json.encode({
          'year': year,
          'timeslot': timeslot,
          'floor': floor,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['prediction'];  // API'den gelen tahmin verisini döndürüyoruz
      } else {
        throw Exception('API request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print("Prediction API çağrısı sırasında hata: $e");
      return -1;  // Hata durumunda -1 dönebiliriz.
    }
  }
}
