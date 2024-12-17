import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pages/admin/AdminHomePage.dart'; // Importando a página admin
import 'pages/user/UserHomePage.dart'; // Importando a página user

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tesouraria',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  // Função assíncrona para realizar o login
  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final url = 'https://church-treasury-app.onrender.com/login'; // URL da API de login na nuvem
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        // Exibe o token no console para depuração
        print('Token obtido: $token');

        // Decodificar o token para obter o role
        final role = await _getRoleFromToken(token);

        // Exibe o role no console para depuração
        print('Role do usuário: $role');

        // Navegar para a página correta baseado no role
        if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminHomePage(token: token)),
          );
        } else if (role == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserHomePage(token: token)),
          );
        } else {
          _showErrorDialog(context, 'Papel desconhecido');
        }
      } else {
        setState(() {
          _errorMessage = 'Login falhou: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao conectar: $e';
      });
    }
  }

  // Função para mostrar um erro
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erro'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  // Função para decodificar o role do token JWT
  Future<String> _getRoleFromToken(String token) async {
    try {
      // Divida o token JWT em três partes (header, payload, signature)
      final parts = token.split('.');

      // Certifique-se de que o token tem três partes
      if (parts.length != 3) {
        print('Token mal formatado!');
        return 'user'; // Role default caso o token esteja mal formatado
      }

      // Decodifique o payload do token, que é a segunda parte
      final payload = base64Url.decode(base64Url.normalize(parts[1]));
      final payloadMap = json.decode(utf8.decode(payload));

      // Verifique se o payload contém a chave 'role'
      final role = payloadMap['role'] ?? 'user';
      print('Payload decodificado: $payloadMap');
      return role;
    } catch (e) {
      // Se houver algum erro ao decodificar, trate e retorne 'user' como padrão
      print('Erro ao decodificar token: $e');
      return 'user'; // Caso de erro, assume que o usuário é comum
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login - Tesouraria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

/*
// PAGINA HOME DO ADMIN
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagem carregada da web
            Image.network(
              'https://media1.giphy.com/media/gfZ9ClheLUDQKIJmEH/200w.gif', // Substitua pela URL da imagem do Admin
              width: 300, // Ajuste o tamanho conforme necessário
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text('Bem-vindo, Admin!'),
          ],
        ),
      ),
    );
  }
}

// PAGINA HOME DO USER
class UserHomePage extends StatelessWidget {
  final String token;

  UserHomePage({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Ícone de logout
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // Navega para a tela de login
                (Route<dynamic> route) => false, // Remove todas as rotas anteriores
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://media.tenor.com/-DY1sCSEXqUAAAAM/sad-cat.gif', // URL da imagem do Usuário
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text('Bem-vindo, Usuário!'),
          ],
        ),
      ),
    );
  }
}
*/
