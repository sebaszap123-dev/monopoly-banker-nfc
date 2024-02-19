import 'package:flutter/material.dart';
import 'package:monopoly_banker/interface/widgets/numeric_button.dart';

enum TriggerType { millon, miles, salida }

class MonopolyTriggerButton extends StatelessWidget {
  const MonopolyTriggerButton(
      {super.key, required this.type, required this.onTap});
  final TriggerType type;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return _button(type);
  }

  Widget _button(TriggerType value) {
    late String text;
    late Color color;
    switch (value) {
      case TriggerType.millon:
        text = 'M';
        color = Colors.red;
      case TriggerType.miles:
        text = 'K';
        color = Colors.blue;

      case TriggerType.salida:
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
