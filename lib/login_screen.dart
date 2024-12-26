import 'package:flutter/material.dart';
import 'dashboard_screen.dart';  // Direkt dashboard'a yönlendireceğiz

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Kullanıcı herhangi bir işlem yapmadan direkt dashboard ekranına yönlendirilir
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          },
          child: Text('Devam et'),
        ),
      ),
    );
  }
}
