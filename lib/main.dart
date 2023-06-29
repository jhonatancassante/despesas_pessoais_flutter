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
            ListaTransacao(_transacoes, _excluirTransacao),
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
