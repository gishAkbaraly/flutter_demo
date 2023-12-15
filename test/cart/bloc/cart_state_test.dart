// ignore_for_file: prefer_const_constructors
import 'package:demo/cart/bloc/cart_bloc.dart';
import 'package:demo/cart/models/cart.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeCart extends Fake implements Cart {}

void main() {
  group('CartState', () {
    group('CartLoading', () {
      test('supports value comparison', () {
        expect(CartLoading(), CartLoading());
      });
    });

    group('CartLoaded', () {
      final cart = FakeCart();
      test('supports value comparison', () {
        expect(CartLoaded(cart: cart), CartLoaded(cart: cart));
      });
    });

    group('CartError', () {
      test('supports value comparison', () {
        expect(CartError(), CartError());
      });
    });
  });
}
