import 'package:flutter/material.dart'; // Importa o pacote para trabalhar com a interface gráfica do Flutter.
import 'package:http/http.dart' as http; // Importa o pacote HTTP para fazer requisições HTTP.
import 'dart:convert'; // Importa o pacote para manipulação de JSON.

void main() {
  runApp(MyApp()); // Função que inicializa o aplicativo.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tesouraria', // Título do aplicativo.
      home: LoginPage(), // Define a página inicial como a página de login.
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState(); // Cria o estado da página de login.
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController(); // Controlador para o campo de usuário.
  final TextEditingController _passwordController = TextEditingController(); // Controlador para o campo de senha.
  String? _errorMessage; // Variável para armazenar mensagens de erro, se houver.

  // Função assíncrona para realizar o login
  Future<void> _login() async {
    final username = _usernameController.text; // Obtém o nome de usuário inserido.
    final password = _passwordController.text; // Obtém a senha inserida.

    try {
      // Faz uma requisição HTTP POST para a API de login.
      final response = await http.post(
        Uri.parse('http://10.2.3.221:8080/login'), // URL da API de login (substitua pelo IP correto).
        headers: {'Content-Type': 'application/json'}, // Define o cabeçalho para JSON.
        body: jsonEncode({
          'username': username, // Envia o nome de usuário no corpo da requisição.
          'password': password, // Envia a senha no corpo da requisição.
        }),
      );

      // Verifica se o status da resposta é 200 (OK).
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Decodifica o corpo da resposta.
        final token = data['token']; // Obtém o token JWT retornado pela API.

        // Se o login for bem-sucedido, navega para a HomePage e passa o token.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(token: token), // Passa o token para a HomePage.
          ),
        );
      } else {
        // Se a resposta não for 200, exibe uma mensagem de erro.
        setState(() {
          _errorMessage = 'Login falhou: ${response.statusCode}';
        });
      }
    } catch (e) {
      // Se ocorrer algum erro durante a requisição (ex: falta de conexão), exibe a mensagem de erro.
      setState(() {
        _errorMessage = 'Erro ao conectar: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login - Tesouraria'), // Título da barra superior.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adiciona um padding ao redor da tela.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos na tela.
          children: [
            // Campo para o nome de usuário.
            TextField(
              controller: _usernameController, // Controlador para o campo.
              decoration: InputDecoration(labelText: 'Usuário'), // Label do campo.
            ),
            // Campo para a senha.
            TextField(
              controller: _passwordController, // Controlador para o campo.
              decoration: InputDecoration(labelText: 'Senha'), // Label do campo.
              obscureText: true, // Oculta a senha à medida que o usuário digita.
            ),
            // Exibe a mensagem de erro, se houver.
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage!, // Exibe a mensagem de erro.
                  style: TextStyle(color: Colors.red), // Estilo para a mensagem de erro (cor vermelha).
                ),
              ),
            SizedBox(height: 16), // Espaçamento entre os elementos.
            // Botão de login que chama a função _login quando pressionado.
            ElevatedButton(
              onPressed: _login, // Chama a função _login.
              child: Text('Login'), // Texto do botão.
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String token; // Variável para armazenar o token JWT.

  HomePage({required this.token}); // Construtor que recebe o token.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo pequeno gafanhoto!'), // Título da página de boas-vindas.
      ),
      body: Center(
        // Exibe o token JWT na tela.
        child: Text(
          'Token JWT: $token', // Texto que mostra o token recebido.
          textAlign: TextAlign.center, // Centraliza o texto.
        ),
      ),
    );
  }
}
