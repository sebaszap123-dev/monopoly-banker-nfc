import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/banker_images.dart';

class MonopolyCreditCard extends StatelessWidget {
  const MonopolyCreditCard({
    super.key,
    this.cardHeight = 250,
    this.isSelected = false,
    required this.color,
    required this.onTap,
    required this.cardNumber,
    this.displayName,
    this.transactions = false,
  });

  final double cardHeight;
  final bool isSelected;
  final String cardNumber;
  final String? displayName;
  final Color color;
  final VoidCallback onTap;
  final bool transactions;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: cardHeight, minHeight: cardHeight),
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 2,
          margin: const EdgeInsets.all(12),
          color: color,
          // Establecer el borde según si está seleccionado o no
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Ajusta el radio según lo necesites
            side: BorderSide(
              color: isSelected ? Colors.yellowAccent : Colors.transparent,
              width: 4.0, // Ajusta el grosor del borde según lo necesites
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Image.asset(
                  BankerImages.bannerCard,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 80,
                left: 20,
                child: Text(
                  cardNumber.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
              Positioned(
                bottom: 45,
                left: 20,
                child: Text(
                  displayName?.toString() ?? 'Player',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const Positioned(
                bottom: 10,
                left: 20,
                child: Row(
                  children: [
                    Text(
                      '01/35',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '12/35',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              if (transactions)
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.blue.shade200])),
                        child: const Icon(Icons.done_all, color: Colors.white),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
