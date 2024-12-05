import 'package:flutter/material.dart';

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackupPressed;
  final VoidCallback onEndGamePressed;

  const GameAppBar({
    super.key,
    required this.onBackupPressed,
    required this.onEndGamePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBackupPressed,
      ),
      actions: [
        TextButton(
          onPressed: onEndGamePressed,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: Colors.red,
            ),
            child: const Text(
              'End game',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
