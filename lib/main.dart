import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase'i başlatmak için
import 'HomePage.dart';
import 'firebase_options.dart'; // Firebase yapılandırma bilgilerini içeren dosya
import 'earthquake_list_screen.dart'; // Earthquake listesi için ekranı import ediyoruz

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
      // Ana sayfa olarak HomePage'i tanımlıyoruz
      home: HomePage(),
    );
  }
}
