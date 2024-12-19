import 'package:flutter/material.dart';
import 'pages/login/SplashScreen.dart'; // Caminho correto para a SplashScreen


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tesouraria',
      home: SplashScreen(), // Tela de Splash como inicial
    );
  }
}
