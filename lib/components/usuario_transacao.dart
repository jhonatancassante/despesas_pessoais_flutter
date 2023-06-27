import 'dart:math';

import 'package:despesas_pessoal/components/formulario_transacao.dart';
import 'package:despesas_pessoal/components/lista_transacao.dart';
import 'package:flutter/material.dart';

import '../models/transacao.dart';

class UsuarioTransacao extends StatefulWidget {
  const UsuarioTransacao({super.key});

  @override
  State<UsuarioTransacao> createState() => _UsuarioTransacaoState();
}

class _UsuarioTransacaoState extends State<UsuarioTransacao> {
  final _transacoes = [
    Transacao(
      id: 't1',
      titulo: 'Novo Tênis de Corrida',
      valor: 310.76,
      data: DateTime.now(),
    ),
    Transacao(
      id: 't2',
      titulo: 'Conta de Luz',
      valor: 210.30,
      data: DateTime.now(),
    ),
  ];

  _adicionaTransacao(String titulo, double valor) {
    final novaTransacao = Transacao(
      id: Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      data: DateTime.now(),
    );

    setState(() {
      _transacoes.add(novaTransacao);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListaTransacao(_transacoes),
        FormularioTransacao(_adicionaTransacao),
      ],
    );
  }
}
