import 'package:flutter/material.dart';
import 'package:church_treasury_app/main.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // Para decodificar o token
import '../login/LoginPage.dart';
import 'consultar_relatorios.dart';
import 'envio_comprovantes.dart';
import 'FAQPage.dart';
import 'MessagePage.dart';

class UserHomePage extends StatelessWidget {
  final String token; // Recebe o token para repassá-lo às próximas telas

  UserHomePage({required this.token});

  @override
  Widget build(BuildContext context) {
    // Decodificar o token e pegar o nome do usuário
    final decodedToken = JwtDecoder.decode(token);
    final username = decodedToken['username'] ?? 'Usuário';

    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await _showExitConfirmation(context);
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'AD Belém - Setor 63 - Tesouraria',
            style: TextStyle(color: Colors.white), // Cor das letras
          ),
          centerTitle: true,
          backgroundColor: Colors.black, // Cor de fundo da AppBar
          leading: IconButton(
            icon: Icon(Icons.logout, color: Colors.white), // Cor do ícone
            onPressed: () async {
              final shouldExit = await _showExitConfirmation(context);
              if (shouldExit ?? false) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyApp()), // Volta para a tela de login
                  (route) => false, // Remove todas as rotas anteriores
                );
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Alterado para exibir o nome do usuário no texto de boas-vindas
              Text(
                'Paz do Senhor, $username!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.analytics),
                label: Text('Consultar Relatórios'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ConsultarRelatoriosPage(token: token),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.upload_file),
                label: Text('Envio de Comprovantes'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnvioComprovantesPage(token: token),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.chat),
                label: Text('Chat de Mensagens'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessagePage(token: token),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.help),
                label: Text('Perguntas Frequentes'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FAQPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Botão de logoff com confirmação
  Future<bool?> _showExitConfirmation(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Você realmente deseja sair e voltar à tela de login?'),
          actions: [
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Fecha o diálogo e permanece na página
              },
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Fecha o diálogo e volta para login
              },
            ),
          ],
        );
      },
    );
  }
}
