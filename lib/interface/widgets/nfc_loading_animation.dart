import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NfcLoadingAnimation extends StatelessWidget {
  const NfcLoadingAnimation({
    super.key,
    this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: LoadingAnimationWidget.beat(
            color: color ?? Colors.blue.shade300,
            size: 80,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0, top: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text('Hold your phone near the NFC tag',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                )),
          ),
        )
      ],
    );
  }
}
