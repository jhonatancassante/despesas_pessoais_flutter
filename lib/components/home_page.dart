import 'dart:math';

import 'package:flutter/material.dart';

import '../models/transacao.dart';
import 'formulario_transacao.dart';
import 'grafico.dart';
import 'lista_transacao.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _mostrarGrafico = false;

  final List<Transacao> _transacoes = [];

  List<Transacao> get _transacoesRecentes {
    return _transacoes.where((tr) {
      return tr.data.isAfter(DateTime.now().subtract(
        const Duration(days: 6),
      ));
    }).toList();
  }

  _adicionaTransacao(String titulo, double valor, DateTime data) {
    final novaTransacao = Transacao(
      id: Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      data: data,
    );

    setState(() {
      _transacoes.add(novaTransacao);
    });

    Navigator.of(context).pop();
  }

  _excluirTransacao(String id) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Confirmação de Exclusão'),
          content:
              const Text('Você tem certeza que deseja excluir essa transação?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _transacoes.removeWhere((tr) => tr.id == id);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  _abrirFormularioDeTransacaoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return FormularioTransacao(_adicionaTransacao);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool emPaisagem = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: [
        if (emPaisagem)
          IconButton(
            onPressed: () {
              setState(() {
                _mostrarGrafico = !_mostrarGrafico;
              });
            },
            icon: Icon(_mostrarGrafico ? Icons.list : Icons.show_chart),
          ),
        IconButton(
          onPressed: () => _abrirFormularioDeTransacaoModal(context),
          icon: const Icon(Icons.add),
        ),
      ],
      // backgroundColor: corPrimaria,
    );

    final alturaDisponivel = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_mostrarGrafico || !emPaisagem)
              SizedBox(
                height: alturaDisponivel * (emPaisagem ? 0.8 : 0.3),
                child: Grafico(_transacoesRecentes),
              ),
            if (!_mostrarGrafico || !emPaisagem)
              SizedBox(
                height: alturaDisponivel * (emPaisagem ? 1 : 0.7),
                child: ListaTransacao(_transacoes, _excluirTransacao),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormularioDeTransacaoModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
