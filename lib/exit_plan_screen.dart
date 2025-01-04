import 'package:flutter/material.dart';

class ExitPlanScreen extends StatelessWidget {
  // Pop-up fonksiyonu, her sınıf için çıkış planını ve kat kroki görselini gösterir
  void _showExitPlan(BuildContext context, String className, String exitName, int capacity, String alternativeExit, int timeExit, int timeAlternativeExit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Çıkış Planı - $className'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Uygun çıkış: $exitName'),
              Text('Alternatif çıkış: $alternativeExit'),
              Text('Sınıf Kapasitesi: $capacity kişi'),
              Text('Uygun çıkışdan bir kişi için tahmini tahliye süresi(saniye) : $timeExit'),
              Text('Alternatif çıkışdan bir kişi için tahmini tahliye süresi(saniye) : $timeAlternativeExit'),
              SizedBox(height: 20),
              Text('Acil durumlar için önerilen çıkış planı şu şekildedir:'),
              Text('1. Sınıfın kapasitesine göre en hızlı çıkışı kullanın.'),
              Text('2. Yoğunluk durumunda alternatif çıkışa yönelin.'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Kapat'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Pop-up ile kat kroki görselini göstermek için fonksiyon
  void _showFloorPlan(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kat Krokisi'),
          content: Image.asset(imagePath),  // Resmi pop-up'ta göster
          actions: [
            TextButton(
              child: Text('Kapat'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acil Çıkış Yönergesi"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Kat Listesi
            _buildFloorSection(
              context,
              '5. Kat',
              [
                'DERSLİKLER M501-M511',
                'MYO FOTOĞRAF VE ÇEKİM STÜDYOSU M501',
              ],
              'assets/KAT5.jpeg', // 5. Kat görseli
            ),
            _buildFloorSection(
              context,
              '4. Kat',
              [
                'DERSLİK M401',
                'DERSLİK M402',
                'DERSLİK M403',
                'DERSLİK M404',
                'DERSLİK M405',
                'DERSLİK M406',
              ],
              'assets/KAT4.jpeg', // 4. Kat görseli
            ),
            _buildFloorSection(
              context,
              '3. Kat',
              [
                'DERSLİK M301',
                'DERSLİK M302',
                'DERSLİK M303',
                'DERSLİK M304',
                'DERSLİK M305',
                'DERSLİK M306',
              ],
              'assets/KAT3.jpeg', // 3. Kat görseli
            ),
            _buildFloorSection(
              context,
              '2. Kat',
              [
                'DERSLİK M201',
                'DERSLİK M202',
                'DERSLİK M203',
                'DERSLİK M204',
                'DERSLİK M205',
                'DERSLİK M206',
              ],
              'assets/KAT2.jpeg', // 2. Kat görseli
            ),
            _buildFloorSection(
              context,
              '1. Kat',
              [
                'DERSLİK M101',
                'DERSLİK M102',
                'DERSLİK M103',
                'DERSLİK M102',
                'DERSLİK M105',
                'MYO HAVACILIK PROGRAMLARI UYGULAMA SINIFI M104',
                'SBF FTR MANUEL TERAPİ LABORATUVARI M105',
              ],
              'assets/KAT1.jpeg', // 1. Kat görseli
            ),
            _buildFloorSection(
              context,
              'Zemin Kat',
              [
                'ÖĞRETİM VE ÖĞRENME MERKEZİ (TLC)',
                'LİSANSÜSTÜ EĞİTİM ENSTİTÜSÜ',
                'DERSLİK M01',
                'KANTİN',
              ],
              'assets/ZEMİN.jpeg', // Zemin kat görseli
            ),
          ],
        ),
      ),
    );
  }

  // Kat için listeyi oluşturuyoruz
  Widget _buildFloorSection(BuildContext context, String floor, List<String> rooms, String imagePath) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              floor,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rooms
                  .map((room) {
                return ListTile(
                  title: Text(room),
                  onTap: () {
                    // Sınıf adına tıklanınca uygun çıkış planını gösteriyoruz
                    String exitName = "Büyük merdivenden çıkış"; // Varsayılan çıkış
                    String alternativeExit = "Küçük merdivenden çıkış"; // Varsayılan alternatif çıkış
                    int capacity = 35; // Varsayılan kapasite
                    int timeExit = 119; //uygun çıkış tahliye süresi
                    int timeAlternativeExit  = 122; //alternatif çıkış tahliye süresi

                    // Belirli sınıflar için çıkış rotaları ve kapasiteyi ayarlıyoruz
                    if (room.contains("M401") || room.contains("M402") || room.contains("M405") || room.contains("M406") ||
                        room.contains("M101") || room.contains("M102") || room.contains("M105") ||
                        room.contains("M201") || room.contains("M202") || room.contains("M205") ||
                        room.contains("M206") || room.contains("M301") || room.contains("M302") ||
                        room.contains("M305") || room.contains("M306")) {
                      exitName = "Büyük merdivenden çıkış";
                    } else if (room.contains("M403") || room.contains("M404") || room.contains("M304") || room.contains("M303") || room.contains("M203") || room.contains("M204") || room.contains("M103") || room.contains("M104")) {
                      exitName = "Küçük merdivenden çıkış";
                    }

                    // Pop-up ile çıkış planını gösteriyoruz
                    _showExitPlan(context, room, exitName, capacity, alternativeExit, timeExit, timeAlternativeExit);
                  },
                );
              })
                  .toList(),
            ),
            // Kat kroki görselini gösteren buton
            TextButton(
              onPressed: () {
                _showFloorPlan(context, imagePath); // Kat kroki görselini aç
              },
              child: Text('Kat Krokisi Görüntüle', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
