import 'package:flutter/material.dart';
import 'envio_comprovantes.dart';

class UserHomePage extends StatelessWidget {
  final String token;

  UserHomePage({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home do Tesoureiro'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://media.tenor.com/-DY1sCSEXqUAAAAM/sad-cat.gif',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text('Bem-vindo, Tesoureiro!'),
              SizedBox(height: 20),

              // Botões de navegação
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnvioComprovantesPage(),
                    ),
                  );
                },
                child: Text('Enviar Comprovantes'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Aqui você pode adicionar outra funcionalidade que o tesoureiro tenha que acessar.
                },
                child: Text('Consultar Relatórios'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Navegação para outra tela, se necessário.
                },
                child: Text('Consultar Histórico de Lançamentos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
