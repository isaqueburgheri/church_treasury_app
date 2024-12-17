import 'package:flutter/material.dart';
import 'cadastro_tesoureiros.dart';
import 'listagem_igrejas.dart';
import 'detalhes_igreja.dart';
import 'relatorios.dart';

class AdminHomePage extends StatelessWidget {
  final String token;

  AdminHomePage({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
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
                'https://media1.giphy.com/media/gfZ9ClheLUDQKIJmEH/200w.gif',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text('Bem-vindo, Admin!'),
              SizedBox(height: 20),

              // Botões de navegação
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CadastroTesoureirosPage(),
                    ),
                  );
                },
                child: Text('Cadastro de Tesoureiros'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListagemIgrejasPage(),
                    ),
                  );
                },
                child: Text('Listagem de Igrejas'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesIgrejaPage(),
                    ),
                  );
                },
                child: Text('Detalhes de Igreja'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RelatoriosPage(),
                    ),
                  );
                },
                child: Text('Relatórios Financeiros'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
