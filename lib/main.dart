import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase'i başlatmak için
import 'firebase_options.dart'; // Firebase yapılandırma bilgilerini içeren dosya
import 'dashboard_screen.dart'; // Dashboard ekranını import ediyoruz

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i platforma özel olarak başlatıyoruz
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp()); // MyApp widget'ını çalıştırıyoruz
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deprem Bilgisi Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(), // Ana ekran olarak DashboardScreen'i seçiyoruz
    );
  }
}
