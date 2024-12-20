import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa a biblioteca para formatação de datas

class MessageDetailPage extends StatelessWidget {
  final Map<String, dynamic> message; // Dados da mensagem

  MessageDetailPage({required this.message}); // Construtor atualizado

  // Função para formatar a data
  String formatDate(String rawDate) {
    try {
      final DateTime parsedDate =
          DateTime.parse(rawDate); // Converte o texto em DateTime
      final DateFormat formatter =
          DateFormat('dd-MM-yyyy - HH:mm'); // Define o formato
      return formatter.format(parsedDate); // Retorna a data formatada
    } catch (e) {
      return rawDate; // Retorna a data original se houver erro
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome do remetente
            Text(
              'Enviado por: ${message['nome']}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Congregação (se existir)
            if (message['congregacao'] != null)
              Text(
                'Congregação: ${message['congregacao']}',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 16),
            // Mensagem
            Text(
              'Mensagem:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              message['mensagem'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            // Data de criação
            Text(
              'Enviado em: ${formatDate(message['created_at'])}',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            // Anexo (se existir)
            if (message['anexo_url'] != null)
              TextButton.icon(
                onPressed: () {
                  // Adicione lógica para abrir o anexo
                  print('Abrir anexo: ${message['anexo_url']}');
                },
                icon: Icon(Icons.attach_file),
                label: Text('Visualizar Anexo'),
              ),
            SizedBox(height: 32),
            // Campo para resposta
            TextField(
              decoration: InputDecoration(
                labelText: 'Sua Resposta',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar a resposta
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
