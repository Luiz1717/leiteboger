import 'package:flutter/material.dart';
import 'package:leiteboger/screens/cadastro_screen.dart';
import 'listagem_screen.dart';
import 'resumo_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Boger - Controle de Leite')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Cadastrar Leite'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Listar Leite'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListagemScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Resumo'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResumoScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
