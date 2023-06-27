import 'package:flutter/material.dart';

import '../styles/cores.dart';

class FormularioTransacao extends StatelessWidget {
  final tituloController = TextEditingController();
  final valorController = TextEditingController();

  FormularioTransacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: valorController,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    print(tituloController.text);
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(corPrimaria),
                  ),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    print(valorController.text);
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(corPrimaria),
                  ),
                  child: const Text('Nova Transação'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
