import 'package:isar/isar.dart';
import 'package:monopoly_banker/data/model/money.dart';
part 'property.g.dart';

enum PropertyType {
  coffee,
  skyBlue,
  magenta,
  naranja,
  red,
  yellow,
  green,
  blue,
  servicios,
  ferro,
}

abstract class Property {
  Id id = Isar.autoIncrement;
  @enumerated
  late PropertyType propertyGroup;

  @Index()
  late String title;

  late Money mortgage;

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

  /// Cost of houses or hotels
  late Money houseCost;
}

@collection
class CompanyService extends Property {
  late bool isRentMultipliedBy10;

  Money rent(int diceNumber) {
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
}
