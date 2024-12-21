import 'package:flutter/material.dart';
import 'package:church_treasury_app/pages/admin/AdminMessagePage.dart'; // Importando a página de mensagens
import 'package:church_treasury_app/pages/admin/cadastro_igrejas.dart'; // Importando a página de cadastro de igrejas
import 'package:church_treasury_app/pages/admin/cadastro_tesoureiros.dart'; // Importando a página de cadastro de tesoureiros
import 'package:church_treasury_app/pages/admin/relatorios.dart'; // Importando a página de relatórios

class AdminHomePage extends StatelessWidget {
  final String token;

  AdminHomePage({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AD Belém - Setor 63 - Administrador'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            final shouldExit = await _showExitConfirmation(context);
            if (shouldExit ?? false) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminHomePage(token: token)),
                (route) => false,
              );
            }
          },
        ),
      ),
      body: Stack(
        children: [
          // Background com a imagem
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.imgur.com/rRq4Kvs.png'),
                fit: BoxFit.cover, // A imagem ocupa toda a área disponível
              ),
            ),
          ),
          // Sobreposição escura para melhorar a visibilidade dos botões
          Container(
            color: Colors.black.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width:
                        200, // Largura da imagem (valor fixo, igual à altura para manter quadrado)
                    height:
                        200, // Altura da imagem (valor fixo para manter quadrado)
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Bordas arredondadas
                      border: Border.all(
                          color: Colors.black, width: 4), // Borda preta
                      image: DecorationImage(
                        image: NetworkImage('https://i.imgur.com/JLdV9FS.jpeg'),
                        fit: BoxFit
                            .cover, // A imagem vai cobrir o tamanho do Container
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Espaço entre a imagem e os botões
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // Navegar para a página de mensagens
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminMessagePage(token: token),
                              ),
                            );
                          },
                          icon: Icon(Icons.message,
                              color: Colors.white), // Ícone de mensagens
                          label: Text(
                            'Mensagens',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.black, // Alterado para backgroundColor
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Navegar para a página de cadastro de igrejas
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CadastroIgrejasPage(token: token),
                              ),
                            );
                          },
                          icon: Icon(Icons.account_tree,
                              color:
                                  Colors.white), // Ícone de cadastro de igrejas
                          label: Text(
                            'Cadastro de Igrejas',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.black, // Alterado para backgroundColor
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Navegar para a página de cadastro de tesoureiros
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CadastroTesoureirosPage(token: token),
                              ),
                            );
                          },
                          icon: Icon(Icons.group,
                              color: Colors
                                  .white), // Ícone de cadastro de tesoureiros
                          label: Text(
                            'Cadastro de Tesoureiros',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.black, // Alterado para backgroundColor
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Navegar para a página de relatórios
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RelatoriosPage(token: token),
                              ),
                            );
                          },
                          icon: Icon(Icons.bar_chart,
                              color: Colors.white), // Ícone de relatórios
                          label: Text(
                            'Relatórios',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.black, // Alterado para backgroundColor
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showExitConfirmation(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Você realmente deseja sair e voltar à tela de login?'),
          actions: [
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
