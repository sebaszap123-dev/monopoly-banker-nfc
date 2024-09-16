import 'package:flutter/material.dart';
import 'package:monopoly_banker/interface/widgets/numeric_button.dart';

enum MoneyActionSpecial { millon, miles, salida }

class MonopolyTriggerButton extends StatelessWidget {
  const MonopolyTriggerButton(
      {super.key, required this.type, required this.onTap});
  final MoneyActionSpecial type;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return _button(type);
  }

  Widget _button(MoneyActionSpecial value) {
    late String text;
    late Color color;
    switch (value) {
      case MoneyActionSpecial.millon:
        text = 'M';
        color = Colors.red;
      case MoneyActionSpecial.miles:
        text = 'K';
        color = Colors.blue;

      case MoneyActionSpecial.salida:
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
