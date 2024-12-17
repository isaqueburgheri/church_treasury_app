class ListagemIgrejasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Igrejas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Igreja A'),
            subtitle: Text('Tesoureiro: João Silva'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navegar para detalhes da igreja
            },
          ),
          ListTile(
            title: Text('Igreja B'),
            subtitle: Text('Tesoureiro: Maria Souza'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navegar para detalhes da igreja
            },
          ),
          // Adicionar mais igrejas conforme necessário
        ],
      ),
    );
  }
}
