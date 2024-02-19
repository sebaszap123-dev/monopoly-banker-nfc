import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/banker_images.dart';

class MonopolyCreditCard extends StatelessWidget {
  const MonopolyCreditCard({
    super.key,
    required this.cardHeight,
    this.isSelected = false,
    required this.color,
    required this.onTap,
    required this.cardNumber,
  });

  final double cardHeight;
  final bool isSelected;
  final String cardNumber;
  final Color color;
  final VoidCallback onTap;
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
                bottom: 50,
                left: 20,
                child: Text(
                  cardNumber.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
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
            ],
          ),
        ),
      ),
    );
  }
}
