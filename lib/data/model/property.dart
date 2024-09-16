import 'package:isar/isar.dart';
import 'package:monopoly_banker/data/model/money.dart';
part 'property.g.dart';

enum PropertyType {
  coffee,
  skyBlue,
  magenta,
  orange,
  red,
  yellow,
  green,
  blue,
  services,
  ferro,
}

abstract class Property {
  Id id = Isar.autoIncrement;
  @enumerated
  late PropertyType propertyGroup;

  @Index()
  late String title;

  late Money mortgage;

  bool isMortgage = false;

  @ignore
  Money get buyValue {
    return mortgage * 2;
  }
}

@collection
class House extends Property {
  late Money rent;
  late Money casa1;
  late Money casa2;
  late Money casa3;
  late Money casa4;
  late Money hotel;
  int houses = 0;

  /// Cost of houses or hotels
  late Money houseCost;
  Money toCharge({bool hasGroup = false}) {
    if (houses == 0) return hasGroup ? rent * 2 : rent;
    if (houses == 1) return casa1;
    if (houses == 2) return casa2;
    if (houses == 3) return casa3;
    if (houses == 4) return casa4;

    return hotel;
  }
}

@collection
class CompanyService extends Property {
  late bool isRentMultipliedBy10;

  Money toCharge(int diceNumber) {
    final baseRent =
        Money(type: MoneyType.thousands, value: diceNumber * 10000);
    return isRentMultipliedBy10 ? baseRent * 10 : baseRent * 4;
  }
}

@collection
class RailWay extends Property {
  final Money rent = Money(type: MoneyType.thousands, value: 250);
  final Money own2 = Money(type: MoneyType.thousands, value: 500);
  final Money own3 = Money(type: MoneyType.million, value: 1);
  final Money own4 = Money(type: MoneyType.million, value: 2);

  Money toCharge(int railways) {
    if (railways == 2) return own2;
    if (railways == 3) return own3;
    if (railways == 4) return own4;
    return rent;
  }
}
