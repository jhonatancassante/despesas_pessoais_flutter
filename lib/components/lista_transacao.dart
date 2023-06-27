import 'package:intl/intl.dart';

import '../models/transacao.dart';
import 'package:flutter/material.dart';

import '../styles/cores.dart';

class ListaTransacao extends StatelessWidget {
  final List<Transacao> transacoes;

  const ListaTransacao(this.transacoes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transacoes.map((tr) {
        return Card(
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: corPrimaria as Color,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  'R\$ ${tr.valor.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: corPrimaria,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr.titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('d MMM y').format(tr.data),
                    style: TextStyle(
                      color: cinza600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
