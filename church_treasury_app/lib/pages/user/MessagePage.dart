import 'package:flutter/material.dart';
import 'MessageDetailPage.dart';
import 'package:church_treasury_app/pages/user/UserHomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart'; // Para decodificar o token

class MessagePage extends StatefulWidget {
  final String token; // Recebe o token para repassá-lo às próximas telas

  MessagePage({required this.token});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<dynamic> messages = []; // Lista que vai armazenar as mensagens
  bool isLoading = true; // Variável para controlar o estado de carregamento
  String errorMessage = ''; // Variável para armazenar mensagens de erro
  String username = ''; // Variável para armazenar o nome do usuário

  // Função para buscar as mensagens da API
  Future<void> fetchMessages() async {
    final response = await http.get(
      Uri.parse(
          'https://church-treasury-app.onrender.com/api/mensagens'), // Altere para o seu endpoint correto
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> allMessages =
            json.decode(response.body); // Recebe todas as mensagens
        // Decodifica o token para pegar o role
        final decodedToken = JwtDecoder.decode(widget.token);
        String role = decodedToken['role'] ?? ''; // Pode ser 'user' ou 'admin'

        if (role == 'admin') {
          // Admin verá todas as mensagens com user_id 0 (admin)
          messages = allMessages.where((message) {
            return message['user_id'] ==
                0; // Admin vê todas as mensagens do admin
          }).toList();
        } else {
          // Usuário verá apenas as mensagens do admin (user_id = 0)
          messages = allMessages.where((message) {
            return message['user_id'] ==
                0; // Usuário vê apenas mensagens do admin
          }).toList();
        }
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage =
            'Falha ao carregar mensagens. Status: ${response.statusCode}';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Decodificar o token e pegar o nome do usuário
    final decodedToken = JwtDecoder.decode(widget.token);
    setState(() {
      username = decodedToken['username'] ?? 'Usuário';
    });
    fetchMessages(); // Chama a função para buscar as mensagens assim que a tela for carregada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paz do Senhor, $username!'),
        backgroundColor: Colors.black, // Cor de fundo da AppBar
        foregroundColor: Colors.white, // Cor do texto da AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
              child: isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Indicador de carregamento
                  : errorMessage.isNotEmpty
                      ? Center(
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : messages.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.emoji_emotions, size: 50),
                                  SizedBox(height: 16),
                                  Text(
                                    'Que benção, nenhuma mensagem!',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        message['mensagem'], // Mensagem
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      trailing: message['anexo_url'] != null
                                          ? Icon(Icons.attach_file,
                                              color: Colors.white)
                                          : null,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MessageDetailPage(
                                              message: message,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Divider(color: Colors.white),
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
