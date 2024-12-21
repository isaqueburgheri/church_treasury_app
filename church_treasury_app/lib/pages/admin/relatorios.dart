import 'package:flutter/material.dart';

class RelatoriosPage extends StatelessWidget {
  final String token;

  RelatoriosPage({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios'),
      ),
      body: Center(
        child: Text('Página de Relatórios - Token: $token'),
      ),
    );
  }
}
