import 'package:demo/shopping_repository.dart';
import 'package:demo/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(App(shoppingRepository: ShoppingRepository()));
}
