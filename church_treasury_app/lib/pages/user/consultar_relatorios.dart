import 'package:flutter/material.dart';

class ConsultarRelatoriosPage extends StatelessWidget {
  final String token;

  ConsultarRelatoriosPage({required this.token}); // Construtor que aceita o token

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Relatórios'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          'Aqui você poderá consultar os relatórios!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
