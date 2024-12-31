import 'package:flutter/material.dart';

class ExitPlanScreen extends StatelessWidget {
  // Pop-up fonksiyonu, her sınıf için çıkış planını gösterir
  void _showExitPlan(BuildContext context, String className, String exitName, int capacity, String alternativeExit) {
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
              Text('Kapasite: $capacity kişi'),
              Text('Alternatif çıkış: $alternativeExit'),
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
            ),
            _buildFloorSection(
              context,
              'Bodrum Kat',
              [
                'MF MAKİNA İMALAT LABORATUVARI',
                'BİLGİSAYAR LABORATUVARLARI MB160-MB161',
                'OFİSLER MB157-MB169',
              ],
            ),
            _buildFloorSection(
              context,
              'Bodrum Kat 2',
              [
                'UBYO GASTRONOMİ VE MUTFAK SANATLARI EĞİTİM MUTFAKLARI',
                'DERSLİK MB202',
                'OFİSLER',
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Kat için listeyi oluşturuyoruz
  Widget _buildFloorSection(BuildContext context, String floor, List<String> rooms) {
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
                    int capacity = 100; // Varsayılan kapasite

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
                    _showExitPlan(context, room, exitName, capacity, alternativeExit);
                  },
                );
              })
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
