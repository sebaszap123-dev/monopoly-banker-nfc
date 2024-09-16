import 'package:flutter/material.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/model/property.dart';
import 'package:monopoly_banker/data/service_locator.dart';
import 'package:monopoly_banker/interface/views/eletronic_game/widgets/property_card.dart';

class PropertiesListScreen extends StatelessWidget {
  final List<Property> propertiesToSell;
  final VoidCallback onTap;
  const PropertiesListScreen({
    super.key,
    required this.propertiesToSell,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: propertiesToSell.length,
        itemBuilder: (BuildContext context, int index) {
          final item = propertiesToSell[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: PropertyCard(
              property: item,
              isOwnedByUser: false,
              onBuy: () {
                getIt<ElectronicGameV2Bloc>().add(BuyProperty(item));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onTap,
        label: const Text('Exit'),
        icon: const Icon(Icons.exit_to_app),
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
