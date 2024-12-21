import 'package:flutter/material.dart';
import 'MessageDetailPage.dart';
import 'package:church_treasury_app/pages/user/UserHomePage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart'; // Biblioteca para decodificar JWT
import 'dart:convert';

class MessagePage extends StatefulWidget {
  final String token; // Recebe o token para repassá-lo às próximas telas

  MessagePage({required this.token});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String username = ''; // Inicializa como string vazia para evitar erros
  List<dynamic> messages = []; // Lista que vai armazenar as mensagens

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    decodeUsername(); // Extrai o username do token assim que o contexto estiver disponível
    if (username.isNotEmpty) {
      fetchMessages(); // Chama a função para buscar as mensagens apenas se o username foi corretamente extraído
    }
  }

  // Função para decodificar o token e extrair o username
  void decodeUsername() {
    try {
      print('Token recebido: ${widget.token}'); // Log do token
      Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
      print(
          'Token decodificado: $decodedToken'); // Log do conteúdo completo do token
      if (decodedToken.containsKey('username')) {
        username = decodedToken[
            'username']; // Ajuste conforme o nome do campo no token
        print('Username extraído: $username'); // Log para verificar o username
      } else {
        throw Exception('Chave "username" não encontrada no token');
      }
    } catch (e) {
      print('Erro ao decodificar o token: $e'); // Log do erro
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao decodificar o token: $e')),
        );
      });
    }
  }

  // Função para buscar as mensagens da API
  Future<void> fetchMessages() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://church-treasury-app.onrender.com/api/mensagens?user_id=$username'),
        headers: {
          'Authorization':
              'Bearer ${widget.token}', // Envia o token no cabeçalho
        },
      );

      print(
          'Response status: ${response.statusCode}'); // Log do status da resposta
      print('Response body: ${response.body}'); // Log do corpo da resposta

      if (response.statusCode == 200) {
        setState(() {
          messages = json.decode(response.body);
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Falha ao carregar mensagens')),
          );
        });
      }
    } catch (e) {
      print('Erro ao conectar com o servidor: $e'); // Log do erro
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao conectar com o servidor: $e')),
        );
      });
    }
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
                      .token, // Navega de volta para a tela principal do usuário
                ),
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
                                      message:
                                          message, // Passa a mensagem inteira
                                    ),
                                  ),
                                );
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
