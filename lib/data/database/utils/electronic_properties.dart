import 'package:monopoly_banker/data/model/money.dart';
import 'package:monopoly_banker/data/model/property.dart';

class PropertyManager {
  /// Método para obtener la lista de propiedades ya predefinidas
  static List<Property> getPredefinedProperties() {
    return [
      House()
        ..title = "Avenida báltica"
        ..rent = Money(type: MoneyType.thousands, value: 40)
        ..casa1 = Money(type: MoneyType.thousands, value: 200)
        ..casa2 = Money(type: MoneyType.thousands, value: 600)
        ..casa3 = Money(type: MoneyType.million, value: 1.8)
        ..casa4 = Money(type: MoneyType.million, value: 3.2)
        ..hotel = Money(type: MoneyType.million, value: 4.5)
        ..mortgage = Money(type: MoneyType.thousands, value: 300)
        ..propertyGroup = PropertyType.coffee
        ..houseCost = Money(type: MoneyType.thousands, value: 500),
      House()
        ..title = "Avenida mediterráneo"
        ..rent = Money(type: MoneyType.thousands, value: 20)
        ..casa1 = Money(type: MoneyType.thousands, value: 100)
        ..casa2 = Money(type: MoneyType.thousands, value: 300)
        ..casa3 = Money(type: MoneyType.thousands, value: 900)
        ..casa4 = Money(type: MoneyType.million, value: 1.6)
        ..hotel = Money(type: MoneyType.million, value: 2.5)
        ..mortgage = Money(type: MoneyType.thousands, value: 300)
        ..propertyGroup = PropertyType.coffee
        ..houseCost = Money(type: MoneyType.thousands, value: 500),
      House()
        ..title = "Avenida oriental"
        ..rent = Money(type: MoneyType.thousands, value: 60)
        ..casa1 = Money(type: MoneyType.thousands, value: 300)
        ..casa2 = Money(type: MoneyType.thousands, value: 900)
        ..casa3 = Money(type: MoneyType.million, value: 2.7)
        ..casa4 = Money(type: MoneyType.million, value: 4)
        ..hotel = Money(type: MoneyType.million, value: 5.5)
        ..mortgage = Money(type: MoneyType.thousands, value: 500)
        ..propertyGroup = PropertyType.skyBlue
        ..houseCost = Money(type: MoneyType.thousands, value: 500),
      House()
        ..title = "Avenida connecticut"
        ..rent = Money(type: MoneyType.thousands, value: 80)
        ..casa1 = Money(type: MoneyType.thousands, value: 400)
        ..casa2 = Money(type: MoneyType.million, value: 1)
        ..casa3 = Money(type: MoneyType.million, value: 3)
        ..casa4 = Money(type: MoneyType.million, value: 4.5)
        ..hotel = Money(type: MoneyType.million, value: 5.5)
        ..mortgage = Money(type: MoneyType.thousands, value: 600)
        ..propertyGroup = PropertyType.skyBlue
        ..houseCost = Money(type: MoneyType.thousands, value: 500),
      House()
        ..title = "Avenida vermont"
        ..rent = Money(type: MoneyType.thousands, value: 60)
        ..casa1 = Money(type: MoneyType.thousands, value: 300)
        ..casa2 = Money(type: MoneyType.thousands, value: 900)
        ..casa3 = Money(type: MoneyType.million, value: 2.7)
        ..casa4 = Money(type: MoneyType.million, value: 4)
        ..hotel = Money(type: MoneyType.million, value: 5.5)
        ..mortgage = Money(type: MoneyType.thousands, value: 500)
        ..propertyGroup = PropertyType.skyBlue
        ..houseCost = Money(type: MoneyType.thousands, value: 500),
      House()
        ..title = "Avenida virginia"
        ..rent = Money(type: MoneyType.thousands, value: 120)
        ..casa1 = Money(type: MoneyType.thousands, value: 600)
        ..casa2 = Money(type: MoneyType.million, value: 1.8)
        ..casa3 = Money(type: MoneyType.million, value: 5)
        ..casa4 = Money(type: MoneyType.million, value: 7)
        ..hotel = Money(type: MoneyType.million, value: 9)
        ..mortgage = Money(type: MoneyType.thousands, value: 800)
        ..propertyGroup = PropertyType.magenta
        ..houseCost = Money(type: MoneyType.million, value: 1),
      House()
        ..title = "Plaza san carlos"
        ..rent = Money(type: MoneyType.thousands, value: 100)
        ..casa1 = Money(type: MoneyType.thousands, value: 500)
        ..casa2 = Money(type: MoneyType.million, value: 1.5)
        ..casa3 = Money(type: MoneyType.million, value: 3.5)
        ..casa4 = Money(type: MoneyType.million, value: 6.25)
        ..hotel = Money(type: MoneyType.million, value: 7.5)
        ..mortgage = Money(type: MoneyType.thousands, value: 700)
        ..propertyGroup = PropertyType.magenta
        ..houseCost = Money(type: MoneyType.million, value: 1),
      House()
        ..title = "Avenida estados"
        ..rent = Money(type: MoneyType.thousands, value: 100)
        ..casa1 = Money(type: MoneyType.thousands, value: 500)
        ..casa2 = Money(type: MoneyType.million, value: 1.5)
        ..casa3 = Money(type: MoneyType.million, value: 3.5)
        ..casa4 = Money(type: MoneyType.million, value: 6.25)
        ..hotel = Money(type: MoneyType.million, value: 7.5)
        ..mortgage = Money(type: MoneyType.thousands, value: 700)
        ..propertyGroup = PropertyType.magenta
        ..houseCost = Money(type: MoneyType.million, value: 1),
      House()
        ..title = "Avenida tennessee"
        ..rent = Money(type: MoneyType.thousands, value: 140)
        ..casa1 = Money(type: MoneyType.thousands, value: 700)
        ..casa2 = Money(type: MoneyType.million, value: 2)
        ..casa3 = Money(type: MoneyType.million, value: 5.5)
        ..casa4 = Money(type: MoneyType.million, value: 7.5)
        ..hotel = Money(type: MoneyType.million, value: 9.5)
        ..mortgage = Money(type: MoneyType.thousands, value: 900)
        ..propertyGroup = PropertyType.magenta
        ..houseCost = Money(type: MoneyType.million, value: 1),
      House()
        ..title = "Avenida nueva york"
        ..rent = Money(type: MoneyType.thousands, value: 160)
        ..casa1 = Money(type: MoneyType.thousands, value: 800)
        ..casa2 = Money(type: MoneyType.million, value: 2.2)
        ..casa3 = Money(type: MoneyType.million, value: 6)
        ..casa4 = Money(type: MoneyType.million, value: 8)
        ..hotel = Money(type: MoneyType.million, value: 10)
        ..mortgage = Money(type: MoneyType.million, value: 1)
        ..propertyGroup = PropertyType.magenta
        ..houseCost = Money(type: MoneyType.million, value: 1),
      House()
        ..title = "Plaza ST. JAMES"
        ..rent = Money(type: MoneyType.thousands, value: 140)
        ..casa1 = Money(type: MoneyType.thousands, value: 700)
        ..casa2 = Money(type: MoneyType.million, value: 2)
        ..casa3 = Money(type: MoneyType.million, value: 5.5)
        ..casa4 = Money(type: MoneyType.million, value: 7.5)
        ..hotel = Money(type: MoneyType.million, value: 9.5)
        ..mortgage = Money(type: MoneyType.million, value: 1)
        ..propertyGroup = PropertyType.magenta
        ..houseCost = Money(type: MoneyType.million, value: 1),
      House()
        ..title = "Avenida Indiana"
        ..rent = Money(type: MoneyType.thousands, value: 180)
        ..casa1 = Money(type: MoneyType.thousands, value: 900)
        ..casa2 = Money(type: MoneyType.million, value: 2.5)
        ..casa3 = Money(type: MoneyType.million, value: 7)
        ..casa4 = Money(type: MoneyType.million, value: 8.75)
        ..hotel = Money(type: MoneyType.million, value: 10.5)
        ..mortgage = Money(type: MoneyType.million, value: 1.1)
        ..propertyGroup = PropertyType.red
        ..houseCost = Money(type: MoneyType.million, value: 1.5),
      House()
        ..title = "Avenida Kentucky"
        ..rent = Money(type: MoneyType.thousands, value: 180)
        ..casa1 = Money(type: MoneyType.thousands, value: 900)
        ..casa2 = Money(type: MoneyType.million, value: 2.5)
        ..casa3 = Money(type: MoneyType.million, value: 7)
        ..casa4 = Money(type: MoneyType.million, value: 8.75)
        ..hotel = Money(type: MoneyType.million, value: 10.5)
        ..mortgage = Money(type: MoneyType.million, value: 1.1)
        ..propertyGroup = PropertyType.red
        ..houseCost = Money(type: MoneyType.million, value: 1.5),
      House()
        ..title = "Avenida Illinois"
        ..rent = Money(type: MoneyType.thousands, value: 200)
        ..casa1 = Money(type: MoneyType.million, value: 1)
        ..casa2 = Money(type: MoneyType.million, value: 3)
        ..casa3 = Money(type: MoneyType.million, value: 7.5)
        ..casa4 = Money(type: MoneyType.million, value: 9.25)
        ..mortgage = Money(type: MoneyType.million, value: 1.2)
        ..propertyGroup = PropertyType.red
        ..houseCost = Money(type: MoneyType.million, value: 1.5)
        ..hotel = Money(type: MoneyType.million, value: 11),
      House()
        ..title = "Avenida Ventnor"
        ..rent = Money(type: MoneyType.thousands, value: 220)
        ..casa1 = Money(type: MoneyType.million, value: 1.1)
        ..casa2 = Money(type: MoneyType.million, value: 3.3)
        ..casa3 = Money(type: MoneyType.million, value: 8)
        ..casa4 = Money(type: MoneyType.million, value: 9.75)
        ..hotel = Money(type: MoneyType.million, value: 11.5)
        ..mortgage = Money(type: MoneyType.million, value: 1.3)
        ..propertyGroup = PropertyType.yellow
        ..houseCost = Money(type: MoneyType.million, value: 1.5),
      House()
        ..title = "Avenida Atlántico"
        ..rent = Money(type: MoneyType.thousands, value: 220)
        ..casa1 = Money(type: MoneyType.million, value: 1.1)
        ..casa2 = Money(type: MoneyType.million, value: 3.3)
        ..casa3 = Money(type: MoneyType.million, value: 8)
        ..casa4 = Money(type: MoneyType.million, value: 9.75)
        ..hotel = Money(type: MoneyType.million, value: 11.5)
        ..mortgage = Money(type: MoneyType.million, value: 1.3)
        ..propertyGroup = PropertyType.yellow
        ..houseCost = Money(type: MoneyType.million, value: 1.5),
      House()
        ..title = "Avenida Marvin"
        ..rent = Money(type: MoneyType.thousands, value: 240)
        ..casa1 = Money(type: MoneyType.million, value: 1.2)
        ..casa2 = Money(type: MoneyType.million, value: 3.6)
        ..casa3 = Money(type: MoneyType.million, value: 8.5)
        ..casa4 = Money(type: MoneyType.million, value: 10.25)
        ..hotel = Money(type: MoneyType.million, value: 12)
        ..propertyGroup = PropertyType.yellow
        ..mortgage = Money(type: MoneyType.million, value: 1.4)
        ..houseCost = Money(type: MoneyType.million, value: 1.5),
      House()
        ..title = "Avenida Pennsylvania"
        ..rent = Money(type: MoneyType.thousands, value: 280)
        ..casa1 = Money(type: MoneyType.million, value: 1.5)
        ..casa2 = Money(type: MoneyType.million, value: 4.5)
        ..casa3 = Money(type: MoneyType.million, value: 10)
        ..casa4 = Money(type: MoneyType.million, value: 12)
        ..hotel = Money(type: MoneyType.million, value: 14)
        ..propertyGroup = PropertyType.green
        ..mortgage = Money(type: MoneyType.million, value: 1.6)
        ..houseCost = Money(type: MoneyType.million, value: 2),
      House()
        ..title = "Avenida Pacífico"
        ..rent = Money(type: MoneyType.thousands, value: 260)
        ..casa1 = Money(type: MoneyType.million, value: 1.3)
        ..casa2 = Money(type: MoneyType.million, value: 3.9)
        ..casa3 = Money(type: MoneyType.million, value: 9)
        ..casa4 = Money(type: MoneyType.million, value: 11)
        ..hotel = Money(type: MoneyType.million, value: 12.75)
        ..propertyGroup = PropertyType.green
        ..mortgage = Money(type: MoneyType.million, value: 1.5)
        ..houseCost = Money(type: MoneyType.million, value: 2),
      House()
        ..title = "Avenida Carolina del norte"
        ..rent = Money(type: MoneyType.thousands, value: 260)
        ..casa1 = Money(type: MoneyType.million, value: 1.3)
        ..casa2 = Money(type: MoneyType.million, value: 3.9)
        ..casa3 = Money(type: MoneyType.million, value: 9)
        ..casa4 = Money(type: MoneyType.million, value: 11)
        ..hotel = Money(type: MoneyType.million, value: 12.75)
        ..propertyGroup = PropertyType.green
        ..mortgage = Money(type: MoneyType.million, value: 1.5)
        ..houseCost = Money(type: MoneyType.million, value: 2),
      House()
        ..title = "El muelle"
        ..rent = Money(type: MoneyType.thousands, value: 500)
        ..casa1 = Money(type: MoneyType.million, value: 2)
        ..casa2 = Money(type: MoneyType.million, value: 6)
        ..casa3 = Money(type: MoneyType.million, value: 14)
        ..casa4 = Money(type: MoneyType.million, value: 17)
        ..hotel = Money(type: MoneyType.million, value: 20)
        ..propertyGroup = PropertyType.blue
        ..mortgage = Money(type: MoneyType.million, value: 2)
        ..houseCost = Money(type: MoneyType.million, value: 2),
      House()
        ..title = "Plaza park"
        ..rent = Money(type: MoneyType.thousands, value: 350)
        ..casa1 = Money(type: MoneyType.million, value: 1.75)
        ..casa2 = Money(type: MoneyType.million, value: 5)
        ..casa3 = Money(type: MoneyType.million, value: 11)
        ..casa4 = Money(type: MoneyType.million, value: 13)
        ..hotel = Money(type: MoneyType.million, value: 15)
        ..propertyGroup = PropertyType.blue
        ..mortgage = Money(type: MoneyType.million, value: 1.75)
        ..houseCost = Money(type: MoneyType.million, value: 2),
      CompanyService()
        ..title = "Compañía de electricidad"
        ..mortgage = Money(type: MoneyType.thousands, value: 750)
        ..propertyGroup = PropertyType.servicios,
      CompanyService()
        ..title = "Compañía de agua"
        ..mortgage = Money(type: MoneyType.thousands, value: 750)
        ..propertyGroup = PropertyType.servicios,
      FerroService()
        ..title = "Ferrocarril Pennsylvania"
        ..mortgage = Money(type: MoneyType.million, value: 1)
        ..propertyGroup = PropertyType.ferro,
      FerroService()
        ..title = "Ferrocarril Reading"
        ..mortgage = Money(type: MoneyType.million, value: 1)
        ..propertyGroup = PropertyType.ferro,
      FerroService()
        ..title = "Ferrocarril B. & O."
        ..mortgage = Money(type: MoneyType.million, value: 1)
        ..propertyGroup = PropertyType.ferro,
      FerroService()
        ..title = "Ferrocarril vía rapida."
        ..mortgage = Money(type: MoneyType.million, value: 1)
        ..propertyGroup = PropertyType.ferro,
    ];
  }
}
