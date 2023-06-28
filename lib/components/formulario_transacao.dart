import 'package:flutter/material.dart';

class FormularioTransacao extends StatefulWidget {
  final void Function(String, double) aoEnviar;

  const FormularioTransacao(this.aoEnviar, {super.key});

  @override
  State<FormularioTransacao> createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<FormularioTransacao> {
  final tituloController = TextEditingController();

  final valorController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _validarCampoVazio(valor) {
    if (valor == null || valor.isEmpty) {
      return 'Esse campo não pode estar vazio!';
    }
    return null;
  }

  String? _validarCampoDouble(valor) {
    if (!valor.isEmpty && double.tryParse(valor) == null) {
      return 'Valor inválido! Utilize o ponto ao invés da vírgula.';
    }

    return _validarCampoVazio(valor);
  }

  _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      final titulo = tituloController.text;
      final valor = double.tryParse(valorController.text) ?? 0.0;
      widget.aoEnviar(titulo, valor);
    }
  }

  _cancelarFormulario() {
    tituloController.clear();
    valorController.clear();
    Navigator.of(context).pop();
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
                validator: _validarCampoVazio,
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
                validator: _validarCampoDouble,
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
