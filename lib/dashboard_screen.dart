import 'dart:typed_data'; // Int64List kullanabilmek için gerekli

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:acileko/utils/api_service.dart'; // API servisi

class DashboardScreen extends StatefulWidget {
  final List<dynamic> earthquakes; // Deprem verisi parametresi

  // Constructor ile earthquakes parametresini alıyoruz
  DashboardScreen({required this.earthquakes});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late FlutterLocalNotificationsPlugin _notifications;

  @override
  void initState() {
    super.initState();
    _initializeNotifications(); // Bildirimleri başlatıyoruz
  }

  // Bildirimleri başlatmak için bir fonksiyon
  void _initializeNotifications() {
    _notifications = FlutterLocalNotificationsPlugin();
    var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher'); // Uygulama ikonunu ayarlıyoruz
    var initializationSettings = InitializationSettings(android: androidSettings);
    _notifications.initialize(initializationSettings); // Bildirimleri başlatıyoruz
  }

  // Bildirimleri göstermek için bir fonksiyon
  Future<void> _showNotification(String title, String body) async {
    // Int64List türü ile vibrationPattern oluşturuluyor
    var vibrationPattern = Int64List.fromList([0, 1000, 500, 1000]); // Titreşim deseni

    var androidDetails = AndroidNotificationDetails(
      'earthquake_channel',
      'Earthquake Alerts',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,  // Sesli bildirim
      enableVibration: true,  // Titreşim aktif
      vibrationPattern: vibrationPattern,  // Int64List olarak titreşim deseni
    );
    var platformDetails = NotificationDetails(android: androidDetails);
    await _notifications.show(0, title, body, platformDetails); // Bildirimi gösteriyoruz
  }

  @override
  Widget build(BuildContext context) {
    // Eğer deprem verisi boşsa, bir loading spinner'ı gösteriyoruz.
    if (widget.earthquakes.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Deprem Bilgisi Uygulaması"),
          centerTitle: true,
        ),
        body: Center(child: CircularProgressIndicator()), // Veri yükleniyor göstergesi
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Deprem Bilgisi Uygulaması"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.earthquakes.length, // Depremler listesine göre item sayısını belirliyoruz
        itemBuilder: (context, index) {
          var earthquake = widget.earthquakes[index];
          var magnitude = earthquake["magnitude"];

          if (magnitude >= 3.0) {
            // Eğer deprem büyüklüğü 3.0 ve üzerinde ise bildirim gönderiyoruz
            _showNotification(
                'Yeni Deprem! ${earthquake["location"]}',
                'Büyüklük: $magnitude, Zaman: ${earthquake["time"]}'
            );
          }

          return Card(
            elevation: 3,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'Deprem ${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ), // Depremin sırasını yazdırıyoruz
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Konum: ${earthquake["location"]}'), // Deprem yerini yazdırıyoruz
                  Text('Büyüklük: $magnitude'), // Deprem büyüklüğünü yazdırıyoruz
                  Text('Zaman: ${earthquake["time"]}'), // Deprem zamanını yazdırıyoruz
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
