import 'package:flutter/material.dart';
import 'consultar_relatorios.dart';
import 'envio_comprovantes.dart';
import 'package:church_treasury_app/main.dart'; 


class UserHomePage extends StatelessWidget {
  final String token; // Recebe o token para repassá-lo às próximas telas

  UserHomePage({required this.token});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await _showExitConfirmation(context);
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Área do Usuário'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final shouldExit = await _showExitConfirmation(context);
              if (shouldExit ?? false) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()), // Volta para a tela de login
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
              Text(
                'Bem-vindo!',
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
                      builder: (context) =>
                          EnvioComprovantesPage(token: token),
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
                Navigator.of(context).pop(false); // Fecha o diálogo e permanece na página
              },
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true); // Fecha o diálogo e volta para login
              },
            ),
          ],
        );
      },
    );
  }
}
