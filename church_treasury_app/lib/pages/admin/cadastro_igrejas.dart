import 'package:flutter/material.dart';

class CadastroIgrejasPage extends StatelessWidget {
  final String token;

  CadastroIgrejasPage({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Igrejas'),
      ),
      body: Center(
        child: Text('Página de Cadastro de Igrejas - Token: $token'),
      ),
    );
  }
}
