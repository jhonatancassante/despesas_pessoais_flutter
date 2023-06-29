import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormularioTransacao extends StatefulWidget {
  final void Function(String, double) aoEnviar;

  const FormularioTransacao(this.aoEnviar, {super.key});

  @override
  State<FormularioTransacao> createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<FormularioTransacao> {
  final _tituloController = TextEditingController();
  final _valorController = TextEditingController();
  DateTime? _dataSelecionada;

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
      final titulo = _tituloController.text;
      final valor = double.tryParse(_valorController.text) ?? 0.0;
      widget.aoEnviar(titulo, valor);
    }
  }

  _cancelarFormulario() {
    _tituloController.clear();
    _valorController.clear();
    _dataSelecionada = null;
    Navigator.of(context).pop();
  }

  _mostrarSeletorData() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((data) {
      if (data == null) {
        return;
      }
      setState(() {
        _dataSelecionada = data;
      });
    });
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
                controller: _tituloController,
                onFieldSubmitted: (_) => _enviarFormulario(),
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
                validator: _validarCampoVazio,
              ),
              TextFormField(
                controller: _valorController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (_) => _enviarFormulario(),
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
                validator: _validarCampoDouble,
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _dataSelecionada == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data selecionada ${DateFormat('dd/MM/y').format(_dataSelecionada!)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _mostrarSeletorData,
                      child: const Text(
                        'Selecionar data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    onPressed: _cancelarFormulario,
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  FilledButton(
                    onPressed: _enviarFormulario,
                    child: const Text(
                      'Nova Transação',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
