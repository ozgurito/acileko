import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;

class EarthquakeListScreen extends StatefulWidget {
  @override
  _EarthquakeListScreenState createState() => _EarthquakeListScreenState();
}

class _EarthquakeListScreenState extends State<EarthquakeListScreen> {
  List<Map<String, String>> earthquakes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadEarthquakeData();
  }

  Future<void> _loadEarthquakeData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // XML dosyasını okuyun
      final String xmlString = await rootBundle.loadString('assets/son_depremler.xml');
      final document = xml.XmlDocument.parse(xmlString);

      setState(() {
        earthquakes = document.findAllElements('text:p').map((node) {
          final text = node.text.trim();
          if (text.contains("Tarih Saat")) return null;
          if (text.contains("TÜRKİYE VE YAKIN ÇEVRESİNDEKİ SON DEPREMLER")) return null;

          // Veriyi böl ve haritaya dönüştür
          final parts = text.split(' ');
          return {
            'Tarih': parts[0],
            'Saat': parts[1],
            'Enlem': parts[2],
            'Boylam': parts[3],
            'Derinlik': parts[4],
            'Yer': parts.sublist(7).join(' '),
          };
        }).where((element) => element != null).cast<Map<String, String>>().toList();

        _isLoading = false;
      });
    } catch (e) {
      print("Hata: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Son Depremler'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: earthquakes.length,
        itemBuilder: (context, index) {
          final quake = earthquakes[index];
          return ListTile(
            title: Text("${quake['Yer']}"),
            subtitle: Text("Tarih: ${quake['Tarih']}, Saat: ${quake['Saat']}, Büyüklük: ${quake['Derinlik']} km"),
          );
        },
      ),
    );
  }
}
