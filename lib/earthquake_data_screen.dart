import 'package:flutter/services.dart'; // Assets erişimi için gerekli
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class EarthquakeDataScreen extends StatefulWidget {
  @override
  _EarthquakeDataScreenState createState() => _EarthquakeDataScreenState();
}

class _EarthquakeDataScreenState extends State<EarthquakeDataScreen> {
  List<String> earthquakeData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadEarthquakeData();  // Veriyi yüklemek için fonksiyon çağırma
  }

  Future<void> _loadEarthquakeData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final String xmlString = await rootBundle.loadString('assets/son_depremler.xml');  // XML dosyasını okuma
      final document = XmlDocument.parse(xmlString);  // XML verisini çözme

      setState(() {
        earthquakeData.clear();
        final earthquakes = document.findAllElements('deprem'); // XML'deki deprem öğelerini bul
        for (var earthquake in earthquakes) {
          final date = earthquake.findElements('tarih').single.text;
          final location = earthquake.findElements('yer').single.text;
          final magnitude = earthquake.findElements('buyukluk').single.text;

          // Veriyi listeye ekliyoruz
          earthquakeData.add('$date: $location - Büyüklük: $magnitude');
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error loading earthquake data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Son Depremler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())  // Yükleme göstergesi
            : ListView.builder(
          itemCount: earthquakeData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(earthquakeData[index]),  // Deprem bilgisini listele
            );
          },
        ),
      ),
    );
  }
}
// TODO Implement this library.