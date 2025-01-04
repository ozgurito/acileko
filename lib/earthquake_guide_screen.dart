import 'package:flutter/material.dart';

class EarthquakeGuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İzmir Ekonomi Üniversitesi Deprem Yönergesi'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection(
              '1. Deprem Öncesi Hazırlıklar',
              '1.1 Deprem Tatbikatları ve Eğitimler\n\n'
                  '• Yıllık Tatbikatlar: İzmir Ekonomi Üniversitesi, her yıl düzenli olarak deprem tatbikatı yapmaktadır. Tatbikatlar sırasında, bina sakinlerinin tahliye yolları, güvenli alanlar ve çıkış yöntemleri hakkında pratik yapılır.\n'
                  '• Farkındalık Eğitimleri: Üniversite, öğrencilere ve personele deprem anında yapılacakları anlatan eğitimler düzenler. Bu eğitimler, online platformlar üzerinden verilmektedir.',
              Icons.school,
              Colors.blue,
            ),
            _buildSection(
              '1.2 Güvenli Alanlar ve Tahliye Rotaları',
              '• Güvenli Alanların Belirlenmesi: Üniversite binasında deprem sırasında güvenli alanlar belirlenmiştir. Bu alanlar, yer altı yapılarından, camlardan, ağır eşyalardan uzak, yapıların dayanıklı olduğu bölgelerde seçilmiştir.\n'
                  '• Tahliye Rotaları ve Çıkışlar: Her bina için açıkça işaretlenmiş çıkışlar ve en hızlı tahliye rotaları bulunmaktadır. Bu çıkış yolları ve haritalar, öğrenciler ve personel tarafından kolayca erişilebilir.\n'
                  '• Kapsamlı Harita: Üniversite binalarında, tatbikatlarda kullanılacak ve acil durumlarda hızla erişilebilecek haritalar bulundurulur.',
              Icons.location_on,
              Colors.green,
            ),
            _buildSection(
              '1.3 Acil Çıkış Planları ve Gereksinimleri',
              '• Acil Çıkış Planları: Her katın başlangıcında, odalarda çıkış yolları ve en yakın güvenli alanlar belirten planlar asılıdır.\n'
                  '• Donanım Kontrolü: Binalarda yangın merdivenleri, acil çıkışlar, alarm sistemleri, yangın söndürme cihazları gibi acil durum ekipmanları düzenli olarak kontrol edilip bakımı yapılır.',
              Icons.exit_to_app,
              Colors.red,
            ),
            _buildSection(
              '2. Deprem Anında Yapılacaklar',
              '• Panikten Kaçınma: Deprem başladığında sakin kalınmalı ve panik yapılmamalıdır. Her bireyin önceden belirlenen güvenli alanlara yönelmesi sağlanmalıdır.\n'
                  '• Yüksek ve Tehlikeli Alanlardan Uzak Durma: Binaların üst katlarındaki öğrenciler hemen güvenli alanlara yönelmelidir.',
              Icons.warning,
              Colors.orange,
            ),
            _buildSection(
              '3. Deprem Sonrası Yapılacaklar',
              '• Yapısal Kontrol: Deprem sonrasında binalarda ciddi yapısal hasar olup olmadığı kontrol edilmelidir. Eğer çatlaklar veya yapısal bozulmalar varsa, binanın tahliyesi hızla yapılmalıdır.\n'
                  '• İlk Yardım: Depremde yaralananlar için önceden eğitimli ilk yardım personeli tarafından gerekli müdahale yapılır.\n'
                  '• Psikolojik Destek: Deprem sonrası psikolojik destek ekipleri üniversiteye yönlendirilir.',
              Icons.healing,
              Colors.purple,
            ),
            _buildSection(
              'Acil Durum İletişim Numaraları',
              '• Yangın ve Acil Durum: 110\n'
                  '• Sağlık ve Ambulans: 112\n'
                  '• Belediye İtfaiye: 115\n'
                  '• Üniversite Acil Durum İletişimi: (0 (232) 279 25 25)',
              Icons.phone,
              Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 30),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
