import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/model/property.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({super.key, required this.property});
  final Property property;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            color: property.propertyGroup.color,
            height: 30,
            child: Center(child: Text(property.title)),
          ),
          if (property is House) ...houseCard(property as House),
          if (property is CompanyService)
            Text(
                """Si es dueño de un "Servicio" la renta es 4 veces lo que muestre los dados.*
                  Si es dueño de ambos "Servicios", la renta es 10 veces lo que muestran los dados"""),
          if (property is RailWay) ...railWayCard(property as RailWay),
          Text("Valor de la hipoteca ${property.mortgage.toString()}")
        ],
      ),
    );
  }

  List<Widget> houseCard(House property) => [
        Text("Renta ${property.rent}"),
        for (int i = 1; i <= 4; i++) // O también puede ser i < 5
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Con $i casa"),
              // Muestra el valor correspondiente a la casa según el índice
              Text(getCasaValue(i, property)),
            ],
          ),
        Text("Casas ${property.houseCost.toString()} cada una"),
        Text("Hoteles ${property.houseCost.toString()} cada uno más 4 casas"),
      ];
  List<Widget> railWayCard(RailWay property) => [
        Text("Renta ${property.rent}"),
        for (int i = 2; i <= 4; i++) // O también puede ser i < 5
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Si es dueño de $i"),
              // Muestra el valor correspondiente a la casa según el índice
              Text(getRailWayValue(i, property)),
            ],
          ),
      ];

  String getCasaValue(int i, House property) {
    switch (i) {
      case 1:
        return property.casa1.toString();
      case 2:
        return property.casa2.toString();
      case 3:
        return property.casa3.toString();
      case 4:
        return property.casa4.toString();
      default:
        return 'N/A';
    }
  }

  String getRailWayValue(int i, RailWay property) {
    switch (i) {
      case 2:
        return property.own2.toString();
      case 3:
        return property.own3.toString();
      case 4:
        return property.own4.toString();
      default:
        return 'N/A';
    }
  }
}
