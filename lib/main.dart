import 'package:despesas_pessoal/components/usuario_transacao.dart';
import 'package:despesas_pessoal/styles/cores.dart';
import 'package:flutter/material.dart';

main() => runApp(const DespesasPessoais());

class DespesasPessoais extends StatelessWidget {
  const DespesasPessoais({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        backgroundColor: corPrimaria,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            child: Card(
              color: corPrimaria,
              elevation: 5,
              child: Text(
                'Gráfico',
                style: TextStyle(
                  color: corTextoPrimaria,
                ),
              ),
            ),
          ),
          const UsuarioTransacao(),
        ],
      ),
    );
  }
}
