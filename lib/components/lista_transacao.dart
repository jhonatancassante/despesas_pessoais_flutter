import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transacao.dart';

class ListaTransacao extends StatelessWidget {
  final List<Transacao> transacoes;
  final void Function(String) aoRemover;

  const ListaTransacao(this.transacoes, this.aoRemover, {super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return transacoes.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nenhuma transação cadastrada...',
                    style: tema.textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transacoes.length,
            itemBuilder: (ctx, index) {
              final tr = transacoes[index];
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
            },
          );
  }
}
