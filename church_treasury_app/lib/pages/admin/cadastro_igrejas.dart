import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroIgrejasPage extends StatefulWidget {
  @override
  _CadastroIgrejasPageState createState() => _CadastroIgrejasPageState();
}

class _CadastroIgrejasPageState extends State<CadastroIgrejasPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _responsavelController = TextEditingController();
  String? _errorMessage;

  // Função para enviar o cadastro
  Future<void> _cadastrarIgreja() async {
    final nome = _nomeController.text;
    final endereco = _enderecoController.text;
    final telefone = _telefoneController.text;
    final responsavel = _responsavelController.text;

    try {
      final url = 'https://church-treasury-app.onrender.com/cadastrar_igreja'; // URL do backend para cadastrar a igreja

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nome': nome,
          'endereco': endereco,
          'telefone': telefone,
          'responsavel': responsavel,
        }),
      );

      if (response.statusCode == 200) {
        // Igreja cadastrada com sucesso
        Navigator.pop(context); // Volta para a tela anterior
      } else {
        setState(() {
          _errorMessage = 'Falha ao cadastrar a igreja: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao conectar: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Igreja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome da Igreja'),
              ),
              TextField(
                controller: _enderecoController,
                decoration: InputDecoration(labelText: 'Endereço'),
              ),
              TextField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _responsavelController,
                decoration: InputDecoration(labelText: 'Responsável'),
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
                onPressed: _cadastrarIgreja,
                child: Text('Cadastrar Igreja'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
