import 'package:flutter/material.dart';
import 'package:church_treasury_app/main.dart';  // Adicione esta linha

class UserHomePage extends StatelessWidget {
  final String token;

  UserHomePage({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://media.tenor.com/-DY1sCSEXqUAAAAM/sad-cat.gif',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text('Bem-vindo, Usuário!'),
          ],
        ),
      ),
    );
  }
}
