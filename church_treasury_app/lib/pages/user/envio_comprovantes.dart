import 'package:flutter/material.dart';

class EnvioComprovantesPage extends StatefulWidget {
  final String token;

  EnvioComprovantesPage({required this.token}); // Construtor que aceita o token

  @override
  _EnvioComprovantesPageState createState() => _EnvioComprovantesPageState();
}

class _EnvioComprovantesPageState extends State<EnvioComprovantesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envio de Comprovantes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          'Aqui você poderá enviar comprovantes!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
