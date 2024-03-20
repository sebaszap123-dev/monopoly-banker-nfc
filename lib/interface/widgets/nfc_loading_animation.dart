import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NfcLoadingAnimation extends StatelessWidget {
  const NfcLoadingAnimation({
    super.key,
    this.color,
    this.customText,
  });
  final Color? color;
  final String? customText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (customText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  customText!,
                  textAlign: TextAlign.justify,
                )),
              ],
            ),
          ),
        LoadingAnimationWidget.beat(
          color: color ?? Colors.blue.shade300,
          size: 80,
        ),
        const Text('Hold your phone near the NFC tag',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ))
      ],
    );
  }
}
