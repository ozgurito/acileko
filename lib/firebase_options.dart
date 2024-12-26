import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyBrBEz8zc1nuifwRhPHTdccQi6GNSqFRrw", // API anahtarınızı buraya ekleyin
      authDomain: "acileko-8636f.firebaseapp.com", // Firebase Authentication domain
      projectId: "acileko-8636f", // Firebase projesi ID'si
      storageBucket: "acileko-8636f.firebasestorage.app", // Firebase Storage bucket
      messagingSenderId: "738826349321", // Gönderen ID'si
      appId: "1:738826349321:web:a79846afb7f43426b681d8", // Uygulama ID'si
      measurementId: "G-24JC2F6BL3", // Firebase Analytics ölçüm ID'si
    );
  }
}
