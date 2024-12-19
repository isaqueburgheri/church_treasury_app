import 'package:flutter/material.dart';
import 'package:church_treasury_app/pages/login/LoginPage.dart'; // Importando a tela de login

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  // Navegar para a tela de login após 3 segundos
  Future<void> _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Navega para a tela de login
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removendo a cor de fundo, pois vamos usar a imagem
      body: Center(
        child: Image.network(
          'https://i.imgur.com/i2JjweT.png', // Substitua pela URL da imagem de sua escolha
          fit: BoxFit.cover, // Ajusta a imagem para cobrir a tela toda
          width: double.infinity, // Garante que a imagem ocupe toda a largura da tela
          height: double.infinity, // Garante que a imagem ocupe toda a altura da tela
        ),
      ),
    );
  }
}
