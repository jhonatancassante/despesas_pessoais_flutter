import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transacao.dart';

class ListaTransacao extends StatelessWidget {
  final List<Transacao> transacoes;

  const ListaTransacao(this.transacoes, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transacoes.isEmpty
          ? Column(
              children: [
                Text(
                  'Nenhuma transação cadastrada...',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
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
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            'R\$ ${tr.valor.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.titulo,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.data),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
