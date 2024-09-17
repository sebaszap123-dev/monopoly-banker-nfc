import 'package:isar/isar.dart';
part 'money.g.dart';

/// MILLION: M, THOUSANDS: K
enum MoneyType {
  million, // M
  thousands, // k
}

@embedded
class Money implements Comparable<Money> {
  @Enumerated(EnumType.name)
  MoneyType? type;
  double? value;

  Money({this.type, this.value});

  Money operator *(num multiplier) {
    if (value == null) {
      throw ArgumentError('Value cannot be null for multiplication');
    }
    double newValue = value! * multiplier;
    return _normalize(newValue);
  }

  Money operator +(Money other) {
    double newValue = _convertToThousands() + other._convertToThousands();
    return _normalize(newValue);
  }

  Money operator -(Money other) {
    double newValue = _convertToThousands() - other._convertToThousands();
    return _normalize(newValue);
  }

  Money operator /(num divisor) {
    if (divisor == 0) {
      throw ArgumentError('Cannot divide by zero');
    }
    double newValue = _convertToThousands() / divisor;
    return _normalize(newValue);
  }

  bool operator <(Money other) {
    return _convertToThousands() < other._convertToThousands();
  }

  bool operator >(Money other) {
    return _convertToThousands() > other._convertToThousands();
  }

  bool operator <=(Money other) {
    return _convertToThousands() <= other._convertToThousands();
  }

  bool operator >=(Money other) {
    return _convertToThousands() >= other._convertToThousands();
  }

  double _convertToThousands() {
    if (value == null) {
      throw ArgumentError('Value cannot be null');
    }
    return type == MoneyType.million ? value! * 1000 : value!;
  }

  Money _normalize(double newValue) {
    if (newValue.abs() >= 1000) {
      return Money(type: MoneyType.million, value: newValue / 1000);
    } else {
      return Money(type: MoneyType.thousands, value: newValue);
    }
  }

  @override
  String toString() {
    if (value == null || type == null) {
      return 'Invalid Money';
    }

    // Convertir el valor a miles para trabajar con ambos valores.
    double valueInThousands = _convertToThousands();

    // Calcular millones y miles
    int millions =
        (valueInThousands ~/ 1000).toInt(); // Parte entera de millones
    int thousands = (valueInThousands % 1000).toInt(); // Parte entera de miles

    String result = '';

    // Si hay millones, los mostramos
    if (millions > 0) {
      result += '${millions}M';
    }

    // Si hay miles, los mostramos
    if (thousands > 0) {
      if (millions > 0) {
        result += ' ';
      }
      result += '${thousands}K';
    }

    // Si no hay miles, pero el valor es menor a mil, lo mostramos en miles.
    if (millions == 0 && thousands == 0) {
      result += '${valueInThousands.toStringAsFixed(1)}K';
    }

    return result;
  }

  String toStringFixed() {
    if (value == null || type == null) {
      return 'Invalid Money';
    }
    String suffix = type == MoneyType.million ? 'M' : 'k';
    return '${value!.toStringAsFixed(1)} $suffix';
  }

  @override
  int compareTo(Money other) {
    double thisValue = _convertToThousands();
    double otherValue = other._convertToThousands();

    if (thisValue < otherValue) {
      return -1;
    } else if (thisValue > otherValue) {
      return 1;
    } else {
      return 0;
    }
  }

  static Money zero() {
    return Money(type: MoneyType.thousands, value: 0);
  }
}
