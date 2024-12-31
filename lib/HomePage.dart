import 'package:flutter/material.dart';
import 'package:acileko/utils/api_service.dart'; // API servisini import ediyoruz
import 'dashboard_screen.dart';  // Deprem verilerini gösterecek ekran
import 'chatbot_screen.dart';    // Chatbot ekranını import ediyoruz
import 'earthquake_guide_screen.dart';  // Deprem Yönergesi Sayfası
import 'exit_plan_screen.dart';  // Acil çıkış planı sayfası
import 'earthquake_prediction_screen.dart';  // Deprem tahmini ekranı

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AcilEko'),
        backgroundColor: Color(0xFF5A55CA), // Mor tonlarında bir renk
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Bildirimler için bir işlem yapılabilir
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hoşgeldiniz ve tarih kısmı
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF5A55CA), // Mor renk
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Merhaba, Hoşgeldiniz 👋',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  // Bugünün tarihini alıyoruz
                  Text(
                    _getFormattedDate(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Menü Butonları (5 Seçenek)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuButton(
                  context,
                  'İzmir Son Depremler',
                  Icons.location_on,
                      () async {
                    // Deprem verilerini API'den çekme
                    var data = await ApiService.fetchEarthquakeData();
                    // Bu veriyi Dashboard ekranında gösterebiliriz
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(
                          earthquakes: data ?? [], // Data verisi burada veriliyor
                        ),
                      ),
                    );
                  },
                ),
                _buildMenuButton(
                  context,
                  'Okul Acil Çıkış Planı',
                  Icons.school,
                      () {
                    // Acil çıkış planı sayfasına yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExitPlanScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuButton(
                  context,
                  'Deprem Tahmini',
                  Icons.pie_chart,
                      () {
                    // Deprem tahmini sayfasına yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EarthquakePredictionScreen()),
                    );
                  },
                ),
                _buildMenuButton(
                  context,
                  'ChatBot Mesaj yaz..',
                  Icons.chat,
                      () {
                    // Chatbot ekranına geçiş
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatbotScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuButton(
                  context,
                  'Deprem Yönergesi',
                  Icons.book,
                      () {
                    // Deprem yönergesi sayfasına yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EarthquakeGuideScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Menü butonu için fonksiyon
  Widget _buildMenuButton(
      BuildContext context,
      String title,
      IconData icon,
      VoidCallback onPressed,
      ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1), // Sarımsı renk
          borderRadius: BorderRadius.circular(12),
        ),
        width: (MediaQuery.of(context).size.width - 48) / 2, // Buton genişliği
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF5A55CA)),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF5A55CA),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bugün tarihi (gün, ay ve hafta günü) formatında almak için fonksiyon
  String _getFormattedDate() {
    DateTime now = DateTime.now();
    return "${now.day} ${_getMonthName(now.month)} ${_getWeekDayName(now.weekday)}"; // Gün, ay, ve hafta günü
  }

  // Ay ismini alır
  String _getMonthName(int month) {
    switch (month) {
      case 1: return 'Ocak';
      case 2: return 'Şubat';
      case 3: return 'Mart';
      case 4: return 'Nisan';
      case 5: return 'Mayıs';
      case 6: return 'Haziran';
      case 7: return 'Temmuz';
      case 8: return 'Ağustos';
      case 9: return 'Eylül';
      case 10: return 'Ekim';
      case 11: return 'Kasım';
      case 12: return 'Aralık';
      default: return '';
    }
  }

  // Haftanın günü ismini alır (Pazar - Cumartesi)
  String _getWeekDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Pazartesi';
      case 2: return 'Salı';
      case 3: return 'Çarşamba';
      case 4: return 'Perşembe';
      case 5: return 'Cuma';
      case 6: return 'Cumartesi';
      case 7: return 'Pazar';
      default: return '';
    }
  }
}
