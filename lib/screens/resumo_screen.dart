import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/leite_provider.dart';

class ResumoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listaLeite = Provider.of<LeiteProvider>(context).listaLeite;

    return Scaffold(
      appBar: AppBar(title: Text('Resumo de Leite Transportado')),
      body: listaLeite.isEmpty
          ? Center(child: Text('Nenhum dado disponível'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: listaLeite.asMap().entries.map((entry) {
                  int index = entry.key;
                  double quantidade = entry.value['quantidade'];
                  return FlSpot(index.toDouble(), quantidade);
                }).toList(),
                isCurved: true,
                barWidth: 4,
                color: Colors.white,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
