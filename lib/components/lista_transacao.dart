import 'package:flutter/material.dart';
import '../models/transacao.dart';
import 'item_transacao.dart';

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
              return ItemTransacao(
                tema: tema,
                tr: tr,
                aoRemover: aoRemover,
              );
            },
          );
  }
}
