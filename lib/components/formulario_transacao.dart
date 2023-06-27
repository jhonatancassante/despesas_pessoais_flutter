import 'package:flutter/material.dart';

class FormularioTransacao extends StatelessWidget {
  final tituloController = TextEditingController();
  final valorController = TextEditingController();

  final void Function(String, double) aoEnviar;

  final _formKey = GlobalKey<FormState>();

  FormularioTransacao(this.aoEnviar, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Esse campo não pode estar vazio!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: valorController,
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Esse campo não pode estar vazio!';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      tituloController.clear();
                      valorController.clear();
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final titulo = tituloController.text;
                        final valor =
                            double.tryParse(valorController.text) ?? 0.0;
                        aoEnviar(titulo, valor);
                      }
                    },
                    child: const Text('Nova Transação'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
