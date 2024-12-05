import 'package:flutter_test/flutter_test.dart';
import 'package:monopoly_banker/data/model/money.dart';

void main() {
  group('Isar models', () {
    test('user-properties', () {
      final money = Money(type: MoneyType.thousands, value: 700);
      final result = money * 2;
      expect(result.type, equals(MoneyType.million));
      expect(result.value, equals(1.4));
    });
  });
}
