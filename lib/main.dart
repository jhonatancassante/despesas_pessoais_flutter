import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('pt')],
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
          displaySmall: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
  bool _mostrarGrafico = false;

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
      valor: 1230.30,
      data: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transacao(
      id: 't5',
      titulo: 'Lanche',
      valor: 8.30,
      data: DateTime.now().subtract(const Duration(days: 0)),
    ),
    Transacao(
      id: 't6',
      titulo: 'Docinho',
      valor: 12.00,
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
