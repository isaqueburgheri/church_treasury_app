import 'package:flutter/material.dart';

class CadastroTesoureirosPage extends StatelessWidget {
  final String token;

  CadastroTesoureirosPage({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Tesoureiros'),
      ),
      body: Center(
        child: Text('Página de Cadastro de Tesoureiros - Token: $token'),
      ),
    );
  }
}
