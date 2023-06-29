import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transacao.dart';
import 'grafico_barra.dart';

class Grafico extends StatelessWidget {
  final List<Transacao> transacoesRecentes;

  const Grafico(this.transacoesRecentes, {super.key});

  List<Map<String, Object>> get agruparTransacoes {
    return List.generate(7, (index) {
      final diaSemana = DateTime.now().subtract(
        Duration(days: index),
      );

      double somaTotal = 0.0;

      for (var i = 0; i < transacoesRecentes.length; i++) {
        bool mesmoDia = transacoesRecentes[i].data.day == diaSemana.day;
        bool mesmoMes = transacoesRecentes[i].data.month == diaSemana.month;
        bool mesmoAno = transacoesRecentes[i].data.year == diaSemana.year;

        if (mesmoDia && mesmoMes && mesmoAno) {
          somaTotal += transacoesRecentes[i].valor;
        }
      }

      return {
        'dia': DateFormat.E('pt').format(diaSemana)[0].toUpperCase(),
        'valor': somaTotal,
      };
    }).reversed.toList();
  }

  double get _valorTotalSemana {
    return agruparTransacoes.fold(0, (som, tr) {
      return som + (tr['valor'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: agruparTransacoes.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: GraficoBarra(
                rotulo: tr['dia'].toString(),
                valor: tr['valor'] as double,
                percentual: _valorTotalSemana == 0
                    ? 0
                    : (tr['valor'] as double) / _valorTotalSemana,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
