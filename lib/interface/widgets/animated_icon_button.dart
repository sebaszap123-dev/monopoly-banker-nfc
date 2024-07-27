import 'dart:async';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/default_cards.dart';

class AnimatedIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget? icon;
  const AnimatedIconButton(
      {super.key, required this.onPressed, this.icon, this.colorsPlayers});
  final List<Color>? colorsPlayers;
  @override
  AnimatedIconButtonState createState() => AnimatedIconButtonState();
}

class AnimatedIconButtonState extends State<AnimatedIconButton> {
  late Timer _timer;
  late int _currentColorIndex;
  List<Color> _colors = [];
  @override
  void initState() {
    _colors = (widget.colorsPlayers == null || widget.colorsPlayers!.isNotEmpty
        ? widget.colorsPlayers
        : defaultColors)!;
    _currentColorIndex = 0;

    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _colors[_currentColorIndex],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: widget.icon ??
                const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 80,
                ),
          ),
        ],
      ),
    );
  }
}
