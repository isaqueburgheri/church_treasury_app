import 'package:flutter/material.dart';

class ConsultarRelatoriosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Relatórios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Escolha o período para consultar os relatórios:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),

            // Adicionando campos de filtro para data, tipo de relatório, etc.
            ElevatedButton(
              onPressed: () {
                // Navegação para a tela com os relatórios
              },
              child: Text('Consultar Relatório de Janeiro 2024'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Consultar outros relatórios
              },
              child: Text('Consultar Relatório de Fevereiro 2024'),
            ),
          ],
        ),
      ),
    );
  }
}
