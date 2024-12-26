import 'package:flutter/material.dart';
import 'api.service.dart';
import 'scaffold_template.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      title: 'Deprem Bilgi Uygulaması',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Fetch earthquake data
                var data = await ApiService.fetchEarthquakeData();
                print(data); // Replace with proper UI updates
              },
              child: Text('Deprem Bilgilerini Göster'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chatbot');
              },
              child: Text('Chatbot ile Konuş'),
            ),
          ],
        ),
      ),
    );
  }
}
