import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Kandilli API'si
  static const String _kandilliBaseUrl = 'https://api.koeri.boun.edu.tr/deprem/data/get'; // Kandilli API'si endpoint

  // OpenAI API'si
  static const String _openAiBaseUrl = 'https://api.openai.com/v1/completions';
  static const String _openAiApiKey = 'YOUR_API_KEY';  // yapay zeka anahtarı

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

  // Chatbot yanıtını almak için metod (OpenAI GPT-3)
  static Future<String> getChatbotResponse(String userInput) async {
    try {
      final response = await http.post(
        Uri.parse(_openAiBaseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_openAiApiKey',  // OpenAI API anahtarını burada kullanıyoruz
        },
        body: json.encode({
          'model': 'text-davinci-003',  // GPT-3 modelini seçiyoruz
          'prompt': userInput,
          'max_tokens': 100,  // Cevap uzunluğu
          'temperature': 0.7,  // Yanıtın rastgeleliğini ayarlıyoruz
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['choices'][0]['text'].toString().trim();
      } else {
        throw Exception('API request failed');
      }
    } catch (e) {
      print("Chatbot API çağrısı sırasında hata: $e");
      return 'Hata oluştu, tekrar deneyin.';
    }
  }
}
