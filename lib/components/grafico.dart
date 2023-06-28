import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:despesas_pessoal/models/transacao.dart';

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

      print(DateFormat.E().format(diaSemana)[0]);
      print(somaTotal);

      return {
        'dia': DateFormat.E().format(diaSemana)[0],
        'valor': somaTotal,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    agruparTransacoes;
    return const Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
