import 'package:flutter/material.dart';
import 'package:monopoly_banker/interface/widgets/numeric_button.dart';

enum Transactions { add, substract, fromPlayers }

class TransactionButton extends StatelessWidget {
  const TransactionButton(
      {super.key, required this.transactionType, required this.onTap});
  final Transactions transactionType;
  final VoidCallback onTap;
  Widget get _buildWidget {
    late Widget icon;
    const double size = 35;
    const color = Colors.white;
    switch (transactionType) {
      case Transactions.add:
        icon = const Icon(
          Icons.person_add,
          size: size,
          color: color,
        );
        break;
      case Transactions.substract:
        icon = const Stack(
          children: [
            Icon(Icons.person, color: color),
            Positioned(
              top: 0,
              right: 15,
              child: Icon(Icons.remove, color: Colors.white),
            ),
          ],
        );
        break;

      case Transactions.fromPlayers:
        icon = const Icon(
          Icons.groups,
          size: size,
          color: color,
        );
        break;
    }
    return BaseButton(
      onTap: onTap,
      color: Colors.grey,
      icon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget;
  }
}
