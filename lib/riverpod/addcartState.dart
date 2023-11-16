import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signinfirebase/addcart/cart.dart';

abstract class CartState {}

@immutable
class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {}

class CartErrorState extends CartState {
  final String error;
  CartErrorState({required this.error});
}

class CartNotifire extends StateNotifier {
  CartNotifire(super.state);
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartInitialState());
  Future<void> addTocart(Cartitem cartitem) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final cartRef =
          firestore.collection('carts').doc('userId').collection('items');
      final cartDoc = await cartRef.doc(cartitem.productId).get();
      if (cartDoc.exists) {
        // Item already exists in the cart, so update the quantity
        int currentQuantity = cartDoc['quantity'];
        cartRef.doc(cartitem.productId).update({
          'quantity': currentQuantity + 1,
        });
      } else {
        // Item does not exist in the cart, so create a new cart item
        cartRef
            .doc(cartitem.productId)
            .set(cartitem.copyWith(quantity: 1).toMap());
      }
    } on FirebaseException catch (e) {
      e.message;
    }
  }
}
