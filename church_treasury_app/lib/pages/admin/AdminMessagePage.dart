import 'package:flutter/material.dart';
import 'AdminHomePage.dart';
import 'AdminMessageDetailPage.dart';
import 'package:church_treasury_app/pages/user/UserHomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart'; // Para decodificar o token

class AdminMessagePage extends StatefulWidget {
  final String token; // Recebe o token para repassá-lo às próximas telas

  AdminMessagePage({required this.token});

  @override
  _AdminMessagePageState createState() => _AdminMessagePageState();
}

class _AdminMessagePageState extends State<AdminMessagePage> {
  List<dynamic> messages = []; // Lista que vai armazenar as mensagens
  bool isLoading = true; // Variável para controlar o estado de carregamento
  String errorMessage = ''; // Variável para armazenar mensagens de erro
  int userId = 0; // Variável para armazenar o user_id do usuário logado
  String username = ''; // Variável para armazenar o nome de usuário

  // Função para buscar as mensagens da API
  Future<void> fetchMessages() async {
    final response = await http.get(
      Uri.parse(
          'https://church-treasury-app.onrender.com/api/mensagens'), // Altere para o seu endpoint correto
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      }, // Envia o token no cabeçalho
    );

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> allMessages =
            json.decode(response.body); // Recebe todas as mensagens
        messages = allMessages; // O administrador vê todas as mensagens
        isLoading =
            false; // Atualiza o estado para indicar que as mensagens foram carregadas
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
    // Decodificar o token e pegar o user_id e username do usuário
    final decodedToken = JwtDecoder.decode(widget.token);
    setState(() {
      username =
          decodedToken['username'] ?? 'Usuário'; // Obtém o nome de usuário
      print(
          'Username do usuário logado: $username'); // Agora está correto, imprimindo o nome de usuário
    });
    fetchMessages(); // Chama a função para buscar as mensagens assim que a tela for carregada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AD Belém - Setor 63 - Tesouraria'),
        backgroundColor: Colors.black, // Cor de fundo da AppBar
        foregroundColor: Colors.white, // Cor do texto da AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminHomePage(
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
                                                AdminMessageDetailPage(
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
