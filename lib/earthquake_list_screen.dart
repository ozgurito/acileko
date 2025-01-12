import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;

class EarthquakeTableScreen extends StatefulWidget {
  @override
  _EarthquakeTableScreenState createState() => _EarthquakeTableScreenState();
}

class _EarthquakeTableScreenState extends State<EarthquakeTableScreen> {
  List<Map<String, String>> earthquakes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEarthquakeData();
  }

  Future<void> _loadEarthquakeData() async {
    try {
      final String xmlString = await rootBundle.loadString('assets/son_depremler.xml');
      final document = xml.XmlDocument.parse(xmlString);

      setState(() {
        earthquakes = document.findAllElements('text:p').map((node) {
          final text = node.text.trim();
          if (text.contains("Tarih") || text.contains("TÜRKİYE VE YAKIN ÇEVRESİNDEKİ SON DEPREMLER")) return null;

          // Boşluklara göre parçala
          final parts = text.split(RegExp(r'\s{2,}')); // İkiden fazla boşluklara göre böl
          if (parts.length < 5) return null;

          return {
            'Tarih': parts[0],
            'Saat': parts[1],
            'Derinlik': parts[2],
            'Şiddet': parts[3],
            'Yer': parts.sublist(4).join(' '),
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
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 20.0, // Sütunlar arasındaki boşluk
            columns: [
              DataColumn(label: Text('Tarih')),
              DataColumn(label: Text('Saat')),
              DataColumn(label: Text('Derinlik (km)')),
              DataColumn(label: Text('Şiddet')),
              DataColumn(label: Text('Yer')),
            ],
            rows: earthquakes.map((quake) {
              return DataRow(cells: [
                DataCell(Text(quake['Tarih'] ?? '-')),
                DataCell(Text(quake['Saat'] ?? '-')),
                DataCell(Text(quake['Derinlik'] ?? '-')),
                DataCell(Text(quake['Şiddet'] ?? '-')),
                DataCell(Text(quake['Yer'] ?? '-')),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
