import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ListagemScreen extends StatefulWidget {
  @override
  _ListagemScreenState createState() => _ListagemScreenState();
}

class _ListagemScreenState extends State<ListagemScreen> {
  List<Map<String, dynamic>> registrosDeLeite = [];

  @override
  void initState() {
    super.initState();
    _buscarRegistros();
  }

  Future<void> _buscarRegistros() async {
    try {
      final dio = Dio();
      final response = await dio.get('http://localhost:3000/api/cadastro/leite');

      if (response.statusCode == 200) {
        setState(() {
          registrosDeLeite = List<Map<String, dynamic>>.from(response.data);
        });
      }
    } catch (e) {
      print('Erro ao buscar registros: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar registros! Verifique sua conexão.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de Leite'),
      ),
      body: registrosDeLeite.isEmpty
          ? Center(child: Text('Nenhum leite cadastrado ainda!'))
          : ListView.builder(
        itemCount: registrosDeLeite.length,
        itemBuilder: (context, index) {
          final registro = registrosDeLeite[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: Icon(
                Icons.local_shipping,
                color: Colors.blue,
                size: 40,
              ),
              title: Text('Motorista: ${registro['motorista']}'),
              subtitle: Text('Data: ${registro['data']}'),
              trailing: Text(
                '${registro['quantidade']} L',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
