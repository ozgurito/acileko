import 'package:flutter/material.dart';
import 'package:acileko/utils/api_service.dart'; // API servisini import ediyoruz
import 'dashboard_screen.dart';  // Deprem verilerini gösterecek ekran
import 'chatbot_screen.dart';    // Chatbot ekranını import ediyoruz

class HomePage extends StatelessWidget {
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
                  Text(
                    'Perşembe 20 Aralık',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Menü Butonları
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
                _buildMenuButton(
                  context,
                  'Deprem Yönergesi',
                  Icons.book,
                      () {
                    // Deprem yönergesi sayfasına yönlendirme
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
}
