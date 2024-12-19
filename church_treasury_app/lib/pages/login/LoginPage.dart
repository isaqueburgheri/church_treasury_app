import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../user/UserHomePage.dart'; // Importando a página Home do Usuário
import '../admin/AdminHomePage.dart'; // Importando a página Home do Administrador

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;


  // Off
  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // Verificação de usuários offline
    if (username == 'leh' && password == '3101') {
      _navigateToHomePage(UserHomePage(token: 'offline_token_user'));
      return;
    }
    if (username == 'admin' && password == '963741') {
      _navigateToHomePage(AdminHomePage(token: 'offline_token_admin'));
      return;
    }

    // Tentativa de login online
    try {
      final url = 'https://church-treasury-app.onrender.com/login';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        if (token == null || token.isEmpty) {
          _showErrorDialog('Token inválido recebido do servidor.');
          return;
        }

        final role = await _getRoleFromToken(token);

        if (role == 'admin') {
          _navigateToHomePage(AdminHomePage(token: token));
        } else if (role == 'user') {
          _navigateToHomePage(UserHomePage(token: token));
        } else {
          _showErrorDialog('Papel desconhecido: $role');
        }
      } else {
        setState(() {
          _errorMessage = 'Login falhou (${response.statusCode}).';
        });
      }
    } catch (e) {
      _showErrorDialog('Erro ao conectar: $e');
    } finally {
      // Limpa o campo de senha após tentativa
      _passwordController.clear();
    }
  }

  Future<String> _getRoleFromToken(String token) async {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return 'user';

      final payload = base64Url.decode(base64Url.normalize(parts[1]));
      final payloadMap = json.decode(utf8.decode(payload));
      return payloadMap['role'] ?? 'user';
    } catch (_) {
      return 'user';
    }
  }

  void _showErrorDialog(String message) {
    // Limpa o campo de senha ao exibir o erro
    _passwordController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erro'),
        content: Text(message),
        actions: [
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

  void _navigateToHomePage(Widget homePage) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => homePage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login - Tesouraria')),
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
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
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
