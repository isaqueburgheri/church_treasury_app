import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ - Perguntas Frequentes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retorna para a página anterior
          },
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.imgur.com/rRq4Kvs.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with semi-transparent background
          Container(
            color: Colors.black.withOpacity(0.6),
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Perguntas Frequentes e Orientações',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Section 1
                _buildSection(
                  title: 'O Pastor pode ser Tesoureiro da Igreja?',
                  content:
                      'A princípio, a formação de uma diretoria tem como principal objetivo dividir as tarefas administrativas de uma Igreja. '
                      'Porém, em igrejas menores, é muito comum que os pastores não contem com pessoas de confiança para exercerem os cargos de diretoria. '
                      'Com isso, em muitos casos o pastor acumula muitas funções, entre elas, a de tesoureiro. '
                      'Entretanto, mesmo que o cartório autorize o acúmulo de funções por parte do pastor, provavelmente esta não é a melhor opção. '
                      'Pois além de sobrecarregar o pastor, acumular a função de Tesoureiro pode gerar desconforto nos membros em relação à gestão dos recursos financeiros da Igreja. '
                      'Portanto, caso o pastor acumule esta função, é fundamental que tudo seja feito com muita transparência!',
                ),
                // Section 2
                _buildSection(
                  title: 'Como organizar a Tesouraria de uma Igreja',
                  content: 'Toda Igreja deve manter os cuidados com sua saúde financeira, o que permite e dá condições de planejar desde pequenos investimentos até grandes expansões, como compra de imóveis e construção do templo. '
                      '\n\nSeguem algumas dicas sobre como organizar a tesouraria de uma Igreja:\n\n'
                      '* Tenha controle sobre as dívidas da Igreja.\n'
                      '* Mantenha os pagamentos em dia.\n'
                      '* Identifique o uso do dinheiro.',
                ),
                // Section 3
                _buildSection(
                  title: 'Sistema para Tesouraria de Igreja: vale a pena?',
                  content:
                      'Inegavelmente, um sistema financeiro pode facilitar muito a gestão da tesouraria da sua Igreja! '
                      'Porém, muitas igrejas não possuem condições financeiras para investir em um bom sistema. '
                      'Caso não seja possível adquirir um sistema, é recomendável usar uma planilha para auxiliar na gestão.',
                ),
                // Section 4
                _buildSection(
                  title: 'As atribuições de um Tesoureiro',
                  content:
                      'O tesoureiro desempenha um papel fundamental dentro da administração de uma Igreja. Suas atribuições incluem:\n\n'
                      '* Controlar as entradas de Dízimos e Ofertas.\n'
                      '* Escriturar o movimento financeiro mensal.\n'
                      '* Apresentar relatórios financeiros.\n'
                      '* Movimentar, em conjunto com o Presidente, as contas bancárias.\n'
                      '* Realizar pagamentos.\n\n'
                      'Características necessárias para um tesoureiro:\n\n'
                      '* Discrição.\n'
                      '* Disponibilidade de tempo.\n'
                      '* Capacidade de usar sistemas ou planilhas.\n'
                      '* Responsabilidade e dedicação.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Divider(color: Colors.white.withOpacity(0.5)),
        ],
      ),
    );
  }
}
