import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signinfirebase/riverpod/sendoderstate.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier(OrderInictialState());
});
