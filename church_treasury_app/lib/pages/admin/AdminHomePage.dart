import 'package:flutter/material.dart';
import 'package:church_treasury_app/main.dart';  
import '../login/LoginPage.dart';


class AdminHomePage extends StatelessWidget {
  final String token;

  AdminHomePage({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
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
              'https://media1.giphy.com/media/gfZ9ClheLUDQKIJmEH/200w.gif', 
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text('Bem-vindo, Admin!'),
          ],
        ),
      ),
    );
  }
}
