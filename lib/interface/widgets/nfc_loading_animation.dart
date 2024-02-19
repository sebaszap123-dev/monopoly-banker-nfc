import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NfcLoadingAnimation extends StatelessWidget {
  const NfcLoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: LoadingAnimationWidget.beat(
            color: Colors.blue.shade300,
            size: 80,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
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
