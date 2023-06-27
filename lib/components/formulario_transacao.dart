import 'package:flutter/material.dart';

class FormularioTransacao extends StatelessWidget {
  final tituloController = TextEditingController();
  final valorController = TextEditingController();

  final void Function(String, double) aoEnviar;

  final _formKey = GlobalKey<FormState>();

  FormularioTransacao(this.aoEnviar, {super.key});

  String? _validarCampo(valor) {
    if (valor == null || valor.isEmpty) {
      return 'Esse campo não pode estar vazio!';
    }
    return null;
  }

  _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      final titulo = tituloController.text;
      final valor = double.tryParse(valorController.text) ?? 0.0;
      aoEnviar(titulo, valor);
    }
  }

  _cancelarFormulario() {
    tituloController.clear();
    valorController.clear();
  }

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
                onFieldSubmitted: (_) => _enviarFormulario(),
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
                validator: _validarCampo,
              ),
              TextFormField(
                controller: valorController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (_) => _enviarFormulario(),
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
                validator: _validarCampo,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _cancelarFormulario,
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: _enviarFormulario,
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
