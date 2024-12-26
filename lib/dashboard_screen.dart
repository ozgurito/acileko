import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'utils/api_service.dart'; // ApiService'i import ediyoruz

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late FlutterLocalNotificationsPlugin _notifications;
  List<dynamic> earthquakes = []; // Depremler için bir liste

  @override
  void initState() {
    super.initState();
    _initializeNotifications(); // Bildirimleri başlatıyoruz
    _loadEarthquakeData(); // Deprem verilerini yüklüyoruz
  }

  // Bildirimleri başlatmak için bir fonksiyon
  void _initializeNotifications() {
    _notifications = FlutterLocalNotificationsPlugin();
    var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher'); // Uygulama ikonunu ayarlıyoruz
    var initializationSettings = InitializationSettings(android: androidSettings);
    _notifications.initialize(initializationSettings); // Bildirimleri başlatıyoruz
  }

  // Deprem verilerini API'den çekiyoruz
  void _loadEarthquakeData() async {
    earthquakes = await ApiService.fetchEarthquakeData() ?? []; // ApiService'den veri çekiyoruz
    setState(() {}); // Ekranı güncelliyoruz
    if (earthquakes.isNotEmpty) {
      _showNotification("Yeni Deprem!", "Bir deprem tespit edildi."); // Deprem tespit edilirse bildirim gösteriyoruz
    }
  }

  // Bildirimleri göstermek için bir fonksiyon
  Future<void> _showNotification(String title, String body) async {
    var androidDetails = AndroidNotificationDetails(
      'earthquake_channel', 'Earthquake Alerts',
      importance: Importance.high,
      priority: Priority.high,
    ); // Bildirimin detaylarını ayarlıyoruz
    var platformDetails = NotificationDetails(android: androidDetails);
    await _notifications.show(0, title, body, platformDetails); // Bildirimi gösteriyoruz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deprem Bilgisi Uygulaması"),
        centerTitle: true,
      ),
      body: earthquakes.isEmpty
          ? Center(child: CircularProgressIndicator()) // Veri yükleniyor ise bir loading göstergesi
          : ListView.builder(
        itemCount: earthquakes.length, // Depremler listesine göre item sayısını belirliyoruz
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'Deprem ${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ), // Depremin sırasını yazdırıyoruz
              subtitle: Text('Konum: ${earthquakes[index]["location"]}'), // Deprem yerini yazdırıyoruz
            ),
          );
        },
      ),
    );
  }
}
