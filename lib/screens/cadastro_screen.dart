import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'listagem_screen.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _motoristaController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();

  Future<void> _enviarCadastro() async {
    final String motorista = _motoristaController.text;
    final int quantidade = int.tryParse(_quantidadeController.text) ?? 0;

    if (motorista.isEmpty || quantidade <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos corretamente!')),
      );
      return;
    }

    try {
      final dio = Dio();
      final response = await dio.post(
        'http://192.168.2.169:3000/api/cadastro/leite',
        data: {
          'motorista': motorista,
          'quantidade': quantidade,
          'data': _dataSelecionada.toIso8601String(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ListagemScreen()),
        );
      }
    } catch (e) {
      print('Erro ao enviar cadastro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar cadastro! Verifique sua conexão.')),
      );
    }
  }

  void _selecionarData() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dataSelecionada) {
      setState(() {
        _dataSelecionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Leite'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _motoristaController,
              decoration: InputDecoration(labelText: 'Motorista'),
            ),
            TextField(
              controller: _quantidadeController,
              decoration: InputDecoration(labelText: 'Quantidade (em litros)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Data: ${_dataSelecionada.toLocal()}'.split(' ')[0]),
                Spacer(),
                ElevatedButton(
                  onPressed: _selecionarData,
                  child: Text('Selecionar Data'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _enviarCadastro,
              child: Text('Enviar Cadastro'),
            ),
          ],
        ),
      ),
    );
  }
}
