import 'package:flutter/material.dart';
import 'package:church_treasury_app/main.dart';
import 'cadastro_igrejas.dart';
import 'cadastro_tesoureiros.dart';
import 'relatorios.dart';

class AdminHomePage extends StatelessWidget {
  final String token;

  AdminHomePage({required this.token});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await _showExitConfirmation(context);
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'AD Belém - Setor 63 - Administrador',
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
                  MaterialPageRoute(builder: (context) => MyApp()),
                  (route) => false,
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
                'Bem-vindo, Administrador!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.church),
                label: Text('Cadastro de Igrejas'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CadastroIgrejasPage(token: token),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.person_add),
                label: Text('Cadastro de Tesoureiros'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CadastroTesoureirosPage(token: token),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.analytics),
                label: Text('Relatórios'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RelatoriosPage(token: token),
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

  // Confirmação de logoff
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
                Navigator.of(context).pop(false); // Fecha o diálogo
              },
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirma saída
              },
            ),
          ],
        );
      },
    );
  }
}
