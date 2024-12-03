import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LeiteProvider with ChangeNotifier {
  List<Map<String, dynamic>> _listaLeite = [];

  List<Map<String, dynamic>> get listaLeite => _listaLeite;

  LeiteProvider() {
    _carregarDados();
  }

  void adicionarLeite(Map<String, dynamic> novoLeite) {
    _listaLeite.add(novoLeite);
    _salvarDados();
    notifyListeners();
  }

  void _salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('leite', jsonEncode(_listaLeite));
  }

  void _carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    String? dados = prefs.getString('leite');
    if (dados != null) {
      _listaLeite = List<Map<String, dynamic>>.from(jsonDecode(dados));
      notifyListeners();
    }
  }

  void removerLeite(int index) {
    _listaLeite.removeAt(index);
    _salvarDados();
    notifyListeners();
  }

}
