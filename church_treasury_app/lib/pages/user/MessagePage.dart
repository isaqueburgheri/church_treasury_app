import 'package:flutter/material.dart';
import 'MessageDetailPage.dart';
import 'package:church_treasury_app/pages/user/UserHomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessagePage extends StatefulWidget {
  final String token; // Recebe o token para repassá-lo às próximas telas

  MessagePage({required this.token});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<dynamic> messages = []; // Lista que vai armazenar as mensagens

  // Função para buscar as mensagens da API
  Future<void> fetchMessages() async {
    final response = await http.get(
      Uri.parse(
          'https://church-treasury-app.onrender.com/api/mensagens'), // Altere para o seu endpoint correto
      headers: {
        'Authorization': 'Bearer ${widget.token}'
      }, // Envia o token no cabeçalho
    );

    if (response.statusCode == 200) {
      setState(() {
        messages = json.decode(response.body);
      });
    } else {
      // Caso ocorra um erro ao buscar as mensagens
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Falha ao carregar mensagens')));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMessages(); // Chama a função para buscar as mensagens assim que a tela for carregada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mensagens'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserHomePage(
                    token: widget
                        .token), // Navega de volta para a tela principal do usuário
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.imgur.com/rRq4Kvs.png'),
                fit: BoxFit.cover, // A imagem cobre toda a tela
              ),
            ),
          ),
          // Content with semi-transparent background
          Container(
            color: Colors.black.withOpacity(0.6), // Filtro semitransparente
            child: Padding(
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
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Texto branco
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var message = messages[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                message['nome'], // Campo de nome
                                style: TextStyle(
                                  fontWeight: FontWeight
                                      .bold, // Deixa o nome em negrito
                                  fontSize: 20, // Aumenta o tamanho da fonte
                                  color: Colors.white, // Cor do texto
                                ),
                              ),
                              subtitle: Text(
                                message['mensagem'], // Mensagem
                                style: TextStyle(
                                  color: Colors.white, // Cor do texto
                                ),
                              ),
                              trailing: message['anexo_url'] != null
                                  ? Icon(Icons.attach_file,
                                      color: Colors
                                          .white) // Ícone de anexo se houver
                                  : null,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MessageDetailPage(
                                        token: widget.token,
                                        messageId: message[
                                            'id'], // Passa a identificação da mensagem
                                      ),
                                    ));
                              },
                            ),
                            Divider(color: Colors.white), // Linha divisória
                          ],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
