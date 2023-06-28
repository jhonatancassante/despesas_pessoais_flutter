import 'package:flutter/material.dart';
import 'dart:math';
import 'components/formulario_transacao.dart';
import 'components/lista_transacao.dart';
import 'components/grafico.dart';
import 'models/transacao.dart';

main() => runApp(const DespesasPessoais());

class DespesasPessoais extends StatelessWidget {
  const DespesasPessoais({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(
      fontFamily: 'Quicksand',
    );

    return MaterialApp(
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple[900],
          secondary: Colors.deepOrange,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          displaySmall: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
  final List<Transacao> _transacoes = [
    Transacao(
      id: 't0',
      titulo: 'Conta Antiga',
      valor: 400.00,
      data: DateTime.now().subtract(const Duration(days: 33)),
    ),
    Transacao(
      id: 't1',
      titulo: 'Novo Tênis de Corrida',
      valor: 310.76,
      data: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transacao(
      id: 't2',
      titulo: 'Conta de Luz',
      valor: 210.30,
      data: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transacao(
      id: 't3',
      titulo: 'Conta de Água',
      valor: 108.30,
      data: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transacao(
      id: 't4',
      titulo: 'Cartão de Crédito',
      valor: 105848.30,
      data: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transacao(
      id: 't3',
      titulo: 'Lanche',
      valor: 8.30,
      data: DateTime.now().subtract(const Duration(days: 0)),
    ),
  ];

  List<Transacao> get _transacoesRecentes {
    return _transacoes.where((tr) {
      return tr.data.isAfter(DateTime.now().subtract(
        const Duration(days: 6),
      ));
    }).toList();
  }

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
            Grafico(_transacoesRecentes),
            ListaTransacao(_transacoes),
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
