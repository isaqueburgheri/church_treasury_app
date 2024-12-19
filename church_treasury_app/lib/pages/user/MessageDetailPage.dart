import 'package:flutter/material.dart';

class MessageDetailPage extends StatelessWidget {
  final String token; // Token para autenticação ou outras ações
  final int messageId; // ID da mensagem, passado da MessagePage

  MessageDetailPage({required this.token, required this.messageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Mensagem'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a MessagePage
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aqui você pode exibir os detalhes da mensagem
            Text(
              'Mensagem Detalhada #$messageId', // Exemplo de exibição do ID da mensagem
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Aqui estão os detalhes da mensagem...',
              style: TextStyle(fontSize: 18),
            ),
            // Campo para resposta
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: 'Sua Resposta',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar a resposta, por exemplo
                print('Resposta enviada');
              },
              child: Text('Enviar Resposta'),
            ),
          ],
        ),
      ),
    );
  }
}
