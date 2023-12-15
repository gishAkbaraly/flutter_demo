import 'package:bloc_test/bloc_test.dart';
import 'package:demo/cart/bloc/cart_bloc.dart';
import 'package:demo/cart/models/cart.dart';
import 'package:demo/catalog/models/item.dart';
import 'package:demo/shopping_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockShoppingRepository extends Mock implements ShoppingRepository {}

void main() {
  group('CartBloc', () {
    final mockItems = [
      Item(1, 'Pomme #1'),
      Item(2, 'Poire #2'),
      Item(3, 'Poisson #3'),
    ];

    final mockItemToAdd = Item(4, 'Viande #4');
    final mockItemToRemove = Item(2, 'Coca #2');

    late ShoppingRepository shoppingRepository;

    setUp(() {
      shoppingRepository = MockShoppingRepository();
    });

    test('initial state is CartLoading', () {
      expect(
        CartBloc(shoppingRepository: shoppingRepository).state,
        CartLoading(),
      );
    });

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartLoaded] when cart is loaded successfully',
      setUp: () {
        when(shoppingRepository.loadCartItems).thenAnswer((_) async => []);
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      act: (bloc) => bloc.add(CartStarted()),
      expect: () => <CartState>[CartLoading(), const CartLoaded()],
      verify: (_) => verify(shoppingRepository.loadCartItems).called(1),
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartError] when loading the cart throws an error',
      setUp: () {
        when(shoppingRepository.loadCartItems).thenThrow(Exception('Error'));
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      act: (bloc) => bloc..add(CartStarted()),
      expect: () => <CartState>[CartLoading(), CartError()],
      verify: (_) => verify(shoppingRepository.loadCartItems).called(1),
    );

    blocTest<CartBloc, CartState>(
      'emits [] when cart is not finished loading and item is added',
      setUp: () {
        when(
          () => shoppingRepository.addItemToCart(mockItemToAdd),
        ).thenAnswer((_) async {});
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      act: (bloc) => bloc.add(CartItemAdded(mockItemToAdd)),
      expect: () => <CartState>[],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoaded] when item is added successfully',
      setUp: () {
        when(
          () => shoppingRepository.addItemToCart(mockItemToAdd),
        ).thenAnswer((_) async {});
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      seed: () => CartLoaded(cart: Cart(items: mockItems)),
      act: (bloc) => bloc.add(CartItemAdded(mockItemToAdd)),
      expect: () => <CartState>[
        CartLoaded(cart: Cart(items: [...mockItems, mockItemToAdd])),
      ],
      verify: (_) {
        verify(() => shoppingRepository.addItemToCart(mockItemToAdd)).called(1);
      },
    );

    blocTest<CartBloc, CartState>(
      'emits [CartError] when item is not added successfully',
      setUp: () {
        when(
          () => shoppingRepository.addItemToCart(mockItemToAdd),
        ).thenThrow(Exception('Error'));
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      seed: () => CartLoaded(cart: Cart(items: mockItems)),
      act: (bloc) => bloc.add(CartItemAdded(mockItemToAdd)),
      expect: () => <CartState>[CartError()],
      verify: (_) {
        verify(
          () => shoppingRepository.addItemToCart(mockItemToAdd),
        ).called(1);
      },
    );


  });
}
