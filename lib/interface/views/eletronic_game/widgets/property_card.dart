import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/model/property.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final bool isOwnedByUser; // Indica si la propiedad pertenece al usuario
  final VoidCallback? onBuy; // Función para comprar la propiedad
  final VoidCallback? onMortgage; // Función para hipotecar la propiedad

  const PropertyCard({
    super.key,
    required this.property,
    required this.isOwnedByUser,
    this.onBuy,
    this.onMortgage,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.white,
    );
    final TextStyle subtitleStyle = TextStyle(
      fontSize: 14,
      color: Colors.grey.shade600,
    );
    final TextStyle valueStyle = TextStyle(
      fontSize: 16,
      color: Colors.black87,
      fontWeight: FontWeight.w500,
    );

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Cabecera de color con el nombre de la propiedad
          Container(
            width: double.maxFinite,
            color: property.propertyGroup.color,
            height: 40,
            child: Center(
              child: Text(
                property.title,
                style: titleStyle.copyWith(fontSize: 20),
              ),
            ),
          ),

          // Sección de detalles dependiendo del tipo de propiedad
          if (property is House)
            ...houseCard(property as House, subtitleStyle, valueStyle),
          if (property is CompanyService) _companyServiceCard(subtitleStyle),
          if (property is RailWay)
            ...railWayCard(property as RailWay, subtitleStyle, valueStyle),

          // Estado de la propiedad y acciones
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                Text(
                  "Valor de la hipoteca: \$${property.mortgage}",
                  style: subtitleStyle,
                ),
                const SizedBox(height: 10),
                // Botón basado en si es del usuario o no
                if (isOwnedByUser)
                  ElevatedButton(
                    onPressed: onMortgage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                        property.isMortgage ? 'Deshipotecar' : 'Hipotecar'),
                  )
                else
                  Column(
                    children: [
                      const Text(
                        'En venta',
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      ),
                      ElevatedButton(
                        onPressed: onBuy,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Comprar'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> houseCard(
          House property, TextStyle subtitleStyle, TextStyle valueStyle) =>
      [
        _infoRow("Renta", "\$${property.rent}", subtitleStyle, valueStyle),
        for (int i = 1; i <= 4; i++)
          _infoRow("Con $i casa(s)", "\$${getCasaValue(i, property)}",
              subtitleStyle, valueStyle),
        _infoRow("Costo de cada casa", "\$${property.houseCost}", subtitleStyle,
            valueStyle),
        _infoRow("Hoteles (más 4 casas)", "\$${property.houseCost}",
            subtitleStyle, valueStyle),
      ];

  Widget _companyServiceCard(TextStyle subtitleStyle) => Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          """Si es dueño de un "Servicio", la renta es 4 veces lo que muestre los dados.
Si es dueño de ambos "Servicios", la renta es 10 veces lo que muestran los dados.""",
          style: subtitleStyle,
          textAlign: TextAlign.center,
        ),
      );

  List<Widget> railWayCard(
          RailWay property, TextStyle subtitleStyle, TextStyle valueStyle) =>
      [
        _infoRow("Renta", "\$${property.rent}", subtitleStyle, valueStyle),
        for (int i = 2; i <= 4; i++)
          _infoRow("Si es dueño de $i", "\$${getRailWayValue(i, property)}",
              subtitleStyle, valueStyle),
      ];

  Widget _infoRow(String label, String value, TextStyle labelStyle,
          TextStyle valueStyle) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: labelStyle),
            Text(value, style: valueStyle),
          ],
        ),
      );

  String getCasaValue(int i, House property) {
    switch (i) {
      case 1:
        return property.casa1.toStringFixed();
      case 2:
        return property.casa2.toStringFixed();
      case 3:
        return property.casa3.toStringFixed();
      case 4:
        return property.casa4.toStringFixed();
      default:
        return 'N/A';
    }
  }

  String getRailWayValue(int i, RailWay property) {
    switch (i) {
      case 2:
        return property.own2.toStringFixed();
      case 3:
        return property.own3.toStringFixed();
      case 4:
        return property.own4.toStringFixed();
      default:
        return 'N/A';
    }
  }
}
