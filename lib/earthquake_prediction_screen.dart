import 'package:flutter/material.dart';
import 'package:acileko/utils/api_service.dart'; // API servisini import ediyoruz

class EarthquakePredictionScreen extends StatefulWidget {
  @override
  _EarthquakePredictionScreenState createState() => _EarthquakePredictionScreenState();
}

class _EarthquakePredictionScreenState extends State<EarthquakePredictionScreen> {
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _timeslotController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  double _prediction = 0;

  void _getPrediction() async {
    int year = int.parse(_yearController.text);
    int timeslot = int.parse(_timeslotController.text);  // Zaman dilimi
    int floor = int.parse(_floorController.text);  // Kat numarası

    var prediction = await ApiService.getPrediction(year, timeslot, floor);
    setState(() {
      _prediction = prediction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deprem Tahmini'),
        backgroundColor: Color(0xFF5A55CA),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _yearController,
              decoration: InputDecoration(
                labelText: 'Yıl (Örnek: 2024)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _timeslotController,
              decoration: InputDecoration(
                labelText: 'Timeslot (Dakika formatında)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _floorController,
              decoration: InputDecoration(
                labelText: 'Kat (Örnek: 1)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getPrediction,
              child: Text('Tahmin Al'),
            ),
            SizedBox(height: 20),
            Text(
              'Tahmin Edilen Öğrenci Sayısı: $_prediction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
