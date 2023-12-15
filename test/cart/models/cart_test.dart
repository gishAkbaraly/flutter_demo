import 'package:demo/cart/models/cart.dart';
import 'package:demo/catalog/models/item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cart', () {
    final mockItems = [
      Item(1, 'Pomme #1'),
      Item(2, 'Poire #2'),
      Item(3, 'Poisson #3'),
    ];

    test('supports value comparison', () async {
      expect(Cart(items: mockItems), Cart(items: mockItems));
    });

    test('gets correct total price for 2 items', () async {
      expect(Cart(items: mockItems).totalPrice, 42 * 3);
    });
  });
}
