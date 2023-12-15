import 'dart:async';

import 'catalog/models/item.dart';


const _delay = Duration(seconds: 5);

const _catalog = [
  'Pomme',
  'Poire',
  'Poisson',
  'Viande',
  'Poulet',
  'Riz',
];

class ShoppingRepository {
  final _items = <Item>[];

  Future<List<String>> loadCatalog() => Future.delayed(_delay, () => _catalog);

  Future<List<Item>> loadCartItems() => Future.delayed(_delay, () => _items);

  void addItemToCart(Item item) => _items.add(item);

  void removeItemFromCart(Item item) => _items.remove(item);
}
