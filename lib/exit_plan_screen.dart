import 'package:flutter/material.dart';

class ExitPlanScreen extends StatelessWidget {
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
              Text('Tahmini Sınıf Mevcudu: $capacity kişi'),
              Text('Uygun çıkışdan tahmini kat tahliye süresi (saniye): $timeExit'),
              Text('Alternatif çıkışda tahmini kat tahliye süresi (saniye): $timeAlternativeExit'),
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

  void _showFloorPlan(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kat Krokisi'),
          content: Image.asset(imagePath),
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
            _buildFloorSection(
              context,
              '5. Kat',
              [
                'DERSLİK M501',
                'DERSLİK M502',
                'DERSLİK M503',
                'DERSLİK M504',
                'DERSLİK M505',
                'DERSLİK M506',
                'DERSLİK M507',
                'DERSLİK M508',
                'DERSLİK M509',
                'DERSLİK M510',
                'DERSLİK M511',
                'MYO FOTOĞRAF VE ÇEKİM STÜDYOSU'
              ],
              'assets/KAT5.jpeg',
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
                'DERSLİK M406'
              ],
              'assets/KAT4.jpeg',
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
                'DERSLİK M306'
              ],
              'assets/KAT3.jpeg',
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
                'DERSLİK M206'
              ],
              'assets/KAT2.jpeg',
            ),
            _buildFloorSection(
              context,
              '1. Kat',
              [
                'DERSLİK M101',
                'DERSLİK M102',
                'DERSLİK M103',
                'DERSLİK M104',
                'DERSLİK M105',
                'MYO HAVACILIK PROGRAMLARI UYGULAMA SINIFI',
                'SBF FTR MANUEL TERAPİ LABORATUVARI',


              ],
              'assets/KAT1.jpeg',
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
                'assets/ZEMİN.jpeg',
              ),

          ],
        ),
      ),
    );
  }

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
    children: rooms.map((room) {
    return ListTile(
    title: Text(room),
    onTap: () {
    String exitName;
    String alternativeExit;
    int capacity;
    int timeExit;
    int timeAlternativeExit;

    // Her sınıf için özel bilgiler
    if (room == "DERSLİK M501") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 40;
    timeExit = 100;
    timeAlternativeExit = 120;
    } else if (room == "DERSLİK M502") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 30;
    timeExit = 110;
    timeAlternativeExit = 130;
    } else if (room == "DERSLİK M503") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 35;
    timeExit = 95;
    timeAlternativeExit = 115;
    } else if (room == "DERSLİK M504") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 45;
    timeExit = 105;
    timeAlternativeExit = 125;
    } else if (room == "DERSLİK M505") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 50;
    timeExit = 90;
    timeAlternativeExit = 110;
    } else if (room == "DERSLİK M506") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 40;
    timeExit = 100;
    timeAlternativeExit = 120;
    } else if (room == "DERSLİK M507") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 30;
    timeExit = 110;
    timeAlternativeExit = 130;
    } else if (room == "DERSLİK M508") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 35;
    timeExit = 100;
    timeAlternativeExit = 120;
    } else if (room == "DERSLİK M509") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 50;
    timeExit = 90;
    timeAlternativeExit = 110;
    } else if (room == "DERSLİK M510") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 40;
    timeExit = 100;
    timeAlternativeExit = 120;
    } else if (room == "DERSLİK M511") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 30;
    timeExit = 110;
    timeAlternativeExit = 130;
    } else if (room == "DERSLİK M405") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 40;
    timeExit = 95;
    timeAlternativeExit = 115;
    } else if (room == "DERSLİK M406") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 35;
    timeExit = 100;
    timeAlternativeExit = 120;
    } else if (room == "DERSLİK M401") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 45;
    timeExit = 90;
    timeAlternativeExit = 110;
    } else if (room == "DERSLİK M402") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 50;
    timeExit = 95;
    timeAlternativeExit = 115;
    } else if (room == "DERSLİK M403") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 35;
    timeExit = 100;
    timeAlternativeExit = 120;
    } else if (room == "DERSLİK M404") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 40;
    timeExit = 105;
    timeAlternativeExit = 125;
    } else if (room == "DERSLİK M301") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 50;
    timeExit = 90;
    timeAlternativeExit = 110;
    } else if (room == "DERSLİK M302") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 45;
    timeExit = 95;
    timeAlternativeExit = 115;
    } else if (room == "DERSLİK M303") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 40;
    timeExit = 100;
    timeAlternativeExit = 120;
    } else if (room == "DERSLİK M304") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 35;
    timeExit = 105;
    timeAlternativeExit = 125;
    } else if (room == "DERSLİK M305") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 50;
    timeExit = 90;
    timeAlternativeExit = 110;
    } else if (room == "DERSLİK M306") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 45;
    timeExit = 95;
    timeAlternativeExit = 115;
    } else if (room == "DERSLİK M201") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 40;
    timeExit = 100;
    timeAlternativeExit = 120;
    } else if (room == "DERSLİK M202") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 35;
    timeExit = 105;
    timeAlternativeExit = 125;
    } else if (room == "DERSLİK M203") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 45;
    timeExit = 95;
    timeAlternativeExit = 115;
    } else if (room == "DERSLİK M204") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 40;
    timeExit = 100;
    timeAlternativeExit = 120;
    } else if (room == "DERSLİK M205") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 50;
    timeExit = 90;
    timeAlternativeExit = 110;
    } else if (room == "DERSLİK M206") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 45;
    timeExit = 95;
    timeAlternativeExit = 115;
    } else if (room == "DERSLİK M101") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 35;
    timeExit = 119;
    timeAlternativeExit = 122;
    } else if (room == "DERSLİK M102") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 35;
    timeExit = 122;
    timeAlternativeExit = 119;
    } else if (room == "DERSLİK M103") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 35;
    timeExit = 122;
    timeAlternativeExit = 119;
    } else if (room == "DERSLİK M104") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 35;
    timeExit = 122;
    timeAlternativeExit = 119;
    } else if (room == "DERSLİK M105") {
    exitName = "Büyük Merdiven";
    alternativeExit = "Küçük Merdiven";
    capacity = 35;
    timeExit = 119;
    timeAlternativeExit = 122;
    } else if (room == "DERSLİK M106") {
    exitName = "Küçük Merdiven";
    alternativeExit = "Büyük Merdiven";
    capacity = 45;
    timeExit = 95;
    timeAlternativeExit = 115;
    } else {
    exitName = "Bilinmeyen";
    alternativeExit = "Bilinmeyen";
    capacity = 0;
    timeExit = 0;
    timeAlternativeExit = 0;

    }

    _showExitPlan(context, room, exitName, capacity, alternativeExit, timeExit, timeAlternativeExit);
    },
    );
    }).toList(),
    ),
    TextButton(
    onPressed: () {
    _showFloorPlan(context, imagePath);
    },
    child: Text('Kat Krokisi Görüntüle', style: TextStyle(color: Colors.blue)),
    ),
    ],
    ),
        ),
    );
  }
}


