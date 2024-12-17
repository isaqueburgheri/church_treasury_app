class RelatoriosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios Financeiros'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Igreja A'),
            subtitle: Text('Último relatório: 12/12/2024'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navegar para detalhes de igreja
            },
          ),
          ListTile(
            title: Text('Igreja B'),
            subtitle: Text('Último relatório: 10/12/2024'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navegar para detalhes de igreja
            },
          ),
          // Adicionar mais itens conforme necessário
        ],
      ),
    );
  }
}
