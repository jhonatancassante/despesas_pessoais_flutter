import 'package:despesas_pessoal/components/usuario_transacao.dart';
import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        // backgroundColor: corPrimaria,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              child: Card(
                elevation: 5,
                child: Text(
                  'Gráfico',
                ),
              ),
            ),
            UsuarioTransacao(),
          ],
        ),
      ),
    );
  }
}
