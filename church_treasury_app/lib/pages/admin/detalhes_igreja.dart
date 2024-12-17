class DetalhesIgrejaPage extends StatelessWidget {
  final String nomeIgreja;

  DetalhesIgrejaPage({required this.nomeIgreja});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da $nomeIgreja'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Lançamento 1'),
            subtitle: Text('Descrição: Oferta\nValor: R\$ 500,00\nData: 12/12/2024'),
          ),
          ListTile(
            title: Text('Lançamento 2'),
            subtitle: Text('Descrição: Dizimo\nValor: R\$ 300,00\nData: 10/12/2024'),
          ),
          // Adicionar mais lançamentos conforme necessário
        ],
      ),
    );
  }
}
