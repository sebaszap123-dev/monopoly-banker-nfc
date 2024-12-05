import 'package:flutter_test/flutter_test.dart';
import 'package:monopoly_banker/data/model/money.dart';

void main() {
  group('Money', () {
    test('multiplication', () {
      final money = Money(type: MoneyType.thousands, value: 700);
      final result = money * 2;
      expect(result.type, equals(MoneyType.million));
      expect(result.value, equals(1.4));
    });

    test('addition', () {
      final m1 = Money(type: MoneyType.thousands, value: 700);
      final m2 = Money(type: MoneyType.thousands, value: 500);
      final result = m1 + m2;
      expect(result.type, equals(MoneyType.million));
      expect(result.value, equals(1.2));
    });

    test('subtraction', () {
      final m1 = Money(type: MoneyType.thousands, value: 700);
      final m2 = Money(type: MoneyType.thousands, value: 500);
      final result = m1 - m2;
      expect(result.type, equals(MoneyType.thousands));
      expect(result.value, equals(200));
    });

    test('division', () {
      final money = Money(type: MoneyType.million, value: 2.8);
      final result = money / 2;
      expect(result.type, equals(MoneyType.million),
          reason: 'El tipo de moneda no es correcto');
      expect(result.value, equals(1.4), reason: 'El valor no es correcto');
    });

    test('division by zero', () {
      final money = Money(type: MoneyType.thousands, value: 700);
      expect(() => money / 0, throwsArgumentError,
          reason: 'No se puede dividir por cero');
    });
  });
}
