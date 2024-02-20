import 'package:flutter/material.dart';

class MonopolyNumericButton extends BaseButton {
  final int number;
  MonopolyNumericButton({
    Key? key,
    required VoidCallback onTap,
    required this.number,
  }) : super(key: key, onTap: onTap, text: number.toString());
}

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.onTap,
    this.text = '',
    this.color,
    this.icon,
  });

  final VoidCallback onTap;
  final String text;
  final Color? color;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5.0),
      color: color ?? Colors.grey.shade400,
      elevation: 5,
      child: InkWell(
        splashColor: Colors.blue.shade100,
        onTap: () {
          // TODO: PLAY A SOUND WITH JUST_AUDIO FLUTTER PACKAGE
          onTap();
        },
        child: FittedBox(
          child: icon ??
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
        ),
      ),
    );
  }
}
