import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transacao.dart';

class ItemTransacao extends StatelessWidget {
  final ThemeData tema;
  final Transacao tr;
  final void Function(String p1) aoRemover;

  const ItemTransacao({
    super.key,
    required this.tema,
    required this.tr,
    required this.aoRemover,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: tema.colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                'R\$ ${tr.valor > 1000 ? NumberFormat.compactCurrency(
                    decimalDigits: 1,
                    symbol: '',
                  ).format(tr.valor) : tr.valor.toStringAsFixed(2)}',
                style: tema.textTheme.displaySmall,
              ),
            ),
          ),
        ),
        title: Text(
          tr.titulo,
          style: tema.textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('dd MMM y').format(tr.data),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => aoRemover(tr.id),
                icon: Icon(
                  Icons.delete,
                  color: tema.colorScheme.error,
                ),
                label: Text(
                  'Excluir',
                  style: TextStyle(
                    color: tema.colorScheme.error,
                  ),
                ),
              )
            : IconButton(
                onPressed: () => aoRemover(tr.id),
                icon: const Icon(Icons.delete),
                color: tema.colorScheme.error,
              ),
      ),
    );
  }
}
