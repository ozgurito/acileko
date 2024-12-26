import 'package:flutter/material.dart';

class ScaffoldTemplate extends StatelessWidget {
  final String title; // Uygulama çubuğu başlığı
  final Widget body; // Ana içerik
  final FloatingActionButton? floatingActionButton; // Opsiyonel FAB

  // Constructor, floatingActionButton parametresi opsiyonel olarak eklenmiştir
  const ScaffoldTemplate({
    Key? key,
    required this.title,
    required this.body,
    this.floatingActionButton, // FAB opsiyonel hale getirildi
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: body,
      floatingActionButton: floatingActionButton, // FAB opsiyonel olarak ekleniyor
    );
  }
}
