import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraficoBarra extends StatelessWidget {
  final String rotulo;
  final double valor;
  final double percentual;

  const GraficoBarra({
    required this.rotulo,
    required this.valor,
    required this.percentual,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: FittedBox(
              child: Text(
                valor > 1000
                    ? NumberFormat.compactCurrency(
                        decimalDigits: 1,
                        symbol: '',
                      ).format(valor)
                    : valor.toStringAsFixed(2),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            height: 60,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentual,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(rotulo),
        ],
      ),
    );
  }
}
