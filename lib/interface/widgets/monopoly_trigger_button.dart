import 'package:flutter/material.dart';
import 'package:monopoly_banker/interface/widgets/numeric_button.dart';

enum MoneyValue { millon, miles, salida }

class MonopolyTriggerButton extends StatelessWidget {
  const MonopolyTriggerButton(
      {super.key, required this.type, required this.onTap});
  final MoneyValue type;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return _button(type);
  }

  Widget _button(MoneyValue value) {
    late String text;
    late Color color;
    switch (value) {
      case MoneyValue.millon:
        text = 'M';
        color = Colors.red;
      case MoneyValue.miles:
        text = 'K';
        color = Colors.blue;

      case MoneyValue.salida:
        text = 'Salida';
        color = Colors.green;

      default:
        text = 'None';
    }

    return BaseButton(
      onTap: onTap,
      text: text,
      color: color,
    );
  }
}
