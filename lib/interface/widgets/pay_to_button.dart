import 'package:flutter/material.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';

class PayToButton extends StatelessWidget {
  const PayToButton({super.key, required this.payTo, required this.onTap});
  final PayTo payTo;
  final Function(PayTo) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 60),
      child: GestureDetector(
        onTap: () => onTap(payTo),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(payTo.name.toUpperCase()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children,
            ),
          ],
        ),
      ),
    );
  }

  List<Icon> get children {
    switch (payTo) {
      case PayTo.playerToPlayer:
        return <Icon>[
          Icon(Icons.person, color: Colors.black, size: _sizeIcon),
          Icon(Icons.arrow_right_alt, color: Colors.green, size: _sizeIcon),
          Icon(Icons.person, color: Colors.black, size: _sizeIcon),
        ];
      case PayTo.playerToPlayers:
        return <Icon>[
          Icon(Icons.person, color: Colors.black, size: _sizeIcon),
          Icon(Icons.arrow_right_alt, color: Colors.green, size: _sizeIcon),
          Icon(Icons.groups, color: Colors.black, size: _sizeIcon),
        ];
      case PayTo.playersToPlayer:
        return <Icon>[
          Icon(Icons.groups, color: Colors.black, size: _sizeIcon),
          Icon(Icons.arrow_right_alt,
              color: Colors.green, size: _sizeIcon, grade: 90),
          Icon(Icons.person, color: Colors.black, size: _sizeIcon),
        ];
    }
  }

  double get _sizeIcon {
    return 35;
  }
}
