import 'package:flutter/material.dart';
import 'dashboard_screen.dart';  // Direkt dashboard'a yönlendireceğiz

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Sign Up")),//
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
