import 'package:flutter/material.dart';
import 'dart:math';
import 'components/formulario_transacao.dart';
import 'components/lista_transacao.dart';
import 'styles/cores.dart';
import 'models/transacao.dart';

main() => runApp(const DespesasPessoais());

class DespesasPessoais extends StatelessWidget {
  const DespesasPessoais({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.purple[900],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    Navigator.of(context).pop();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          IconButton(
            onPressed: () => _abrirFormularioDeTransacaoModal(context),
            icon: const Icon(Icons.add),
          ),
        ],
        // backgroundColor: corPrimaria,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              child: Card(
                elevation: 5,
                child: Text(
                  'Gráfico',
                ),
              ),
            ),
            ListaTransacao(_transacoes),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormularioDeTransacaoModal(context),
        backgroundColor: corPrimaria,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
