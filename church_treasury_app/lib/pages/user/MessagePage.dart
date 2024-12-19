import 'package:flutter/material.dart';
import 'MessageDetailPage.dart';
import 'UserHomePage.dart'; // Importando a tela UserHomePage

class MessagePage extends StatelessWidget {
  final String token; // Recebe o token para repassá-lo às próximas telas

  MessagePage({required this.token});

  @override
  Widget build(BuildContext context) {
    // Simulação de mensagens, pode ser substituída por dados reais
    final List<String> messages = []; // Lista de mensagens (aqui está vazia, mas pode ser dinâmica)

    return Scaffold(
      appBar: AppBar(
        title: Text('Mensagens'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserHomePage(token: token), // Navega de volta para a tela principal do usuário
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: messages.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.emoji_people, size: 50), // Ícone engraçado
                    SizedBox(height: 16),
                    Text(
                      'Que benção, nenhuma mensagem!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Mensagem ${index + 1}'),
                    subtitle: Text('Data: 12/12/2024'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageDetailPage(
                            token: token,
                            messageId: index, // Passa a identificação da mensagem
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
