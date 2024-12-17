import 'package:flutter/material.dart';

class EnvioComprovantesPage extends StatefulWidget {
  @override
  _EnvioComprovantesPageState createState() => _EnvioComprovantesPageState();
}

class _EnvioComprovantesPageState extends State<EnvioComprovantesPage> {
  final _formKey = GlobalKey<FormState>();
  String? _comprovante;
  String? _descricao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envio de Comprovantes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Por favor, insira as informações do comprovante:', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),

              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição do Comprovante'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descricao = value;
                },
              ),
              SizedBox(height: 20),

              TextFormField(
                decoration: InputDecoration(labelText: 'URL ou Caminho do Comprovante'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o caminho do comprovante';
                  }
                  return null;
                },
                onSaved: (value) {
                  _comprovante = value;
                },
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Aqui você pode chamar a função para enviar os dados ao backend
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Comprovante enviado com sucesso!')));
                  }
                },
                child: Text('Enviar Comprovante'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
