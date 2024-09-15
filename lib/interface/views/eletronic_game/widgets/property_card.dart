import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            color: Colors.grey,
            alignment: Alignment.center,
            child: Text("Avenida baltica"),
          ),
        ],
      ),
    );
  }
}
