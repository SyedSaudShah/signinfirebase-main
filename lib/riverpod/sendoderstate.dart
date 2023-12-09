import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class OrderState {}

@immutable
class OrderInictialState extends OrderState {}

@immutable
class OrderloadingState extends OrderState {}

@immutable
class OrderLoadedState extends OrderState {}

@immutable
class OrderErrorState extends OrderState {
  final String message;

  OrderErrorState({required this.message});
}

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier(OrderInictialState orderInictialState)
      : super(OrderInictialState());
  sendOrder(String userId, String productId, num quantity, String address,
      void submit) async {
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'userId': userId,
        'productId': productId,
        'quantity': quantity,
        'address': address,
        'timestamp':
            FieldValue.serverTimestamp(), // Optional: Include a timestamp
      });
      //  print('Order sent successfully!');
    } on FirebaseException catch (e) {
      e.message;
    }
  }
}
