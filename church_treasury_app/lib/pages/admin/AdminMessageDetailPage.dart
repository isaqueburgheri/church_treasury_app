import 'package:flutter/material.dart';

class AdminMessageDetailPage extends StatelessWidget {
  // Mudando para AdminMessageDetailPage
  final Map<String, dynamic> message;

  AdminMessageDetailPage({required this.message}); // Construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Mensagem'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remetente: ${message['nome']}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Mensagem:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              message['mensagem'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            if (message['anexo_url'] != null && message['anexo_url'] != '')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Anexo:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // Lógica para abrir o anexo, se necessário.
                      print('Abrir anexo: ${message['anexo_url']}');
                    },
                    child: Text(
                      message['anexo_url'],
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 16),
            Text(
              'Data: ${message['created_at']}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
