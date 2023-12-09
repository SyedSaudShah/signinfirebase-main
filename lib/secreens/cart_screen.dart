import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signinfirebase/Modelclass/location.dart';
import 'package:signinfirebase/addcart/cart.dart';
import 'package:signinfirebase/riverpod/sendOderproverd.dart';

class OrderInicitalState extends ConsumerWidget {
  const OrderInicitalState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersending = ref.watch(orderProvider.notifier);
    return Scaffold(
      body: Builder(
        builder: (context) {
          if (ordersending is OrderInicitalState) {
            return const OrderLoadingState();
          } else if (ordersending is OrderLoadedState) {
            return const Text('Order Loaded State');
          } else {
            return OrderErrorStateWidget(
                errorMessage:
                    (ordersending as OrderErrorStateWidget).errorMessage);
          }
        },
      ),
    );
  }
}

class OrderLoadingState extends ConsumerWidget {
  const OrderLoadingState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CircularProgressIndicator(
      color: Colors.red,
    );
  }
}

class OrderLoadedState extends ConsumerWidget {
  const OrderLoadedState({super.key});
  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    return FirebaseFirestore.instance
        .collection('carts')
        .doc('userId')
        .collection('items')
        .get();
  }

  Future<UserLocation?> getUserLocation() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users') // Replace with your collection name
              .doc('user_id') // Replace with the user's ID
              .get();

      if (snapshot.exists) {
        return UserLocation.fromMap(snapshot.data()!);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      e.message;
      // print('Error getting user location: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(orderProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent[400],
          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          title: const Text('Cart'),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 10.00,
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text("No data available"),
                );
              } else {
                // print('Firestore Data: ${snapshot.data?.docs}');
                var cartItems = snapshot.data!.docs;

                List<Cartitem> list = cartItems
                    .map((e) =>
                        Cartitem.fromMap(e.data() as Map<String, dynamic>))
                    .toList();

                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      // print('firsttttttttttttttttttttttttttttttttt${cartItems}');

                      return GestureDetector(
                        onTap: () {
                          // ignore: no_leading_underscores_for_local_identifiers

                          TextEditingController quantityController =
                              TextEditingController();
                          TextEditingController adresscontroller =
                              TextEditingController();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm Order'),
                              content: Column(
                                children: [
                                  Image.network(list[index].img),
                                  Row(
                                    children: [
                                      Text(list[index].name),
                                      Text(list[index].price.toString()),
                                    ],
                                  ),
                                  Text(
                                      'Are you sure you want to order ${list[index].name}?'),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter your Quantity';
                                      }
                                      return null;
                                    },
                                    controller: quantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top:
                                              20), // add padding to adjust text
                                      isDense: true,
                                      hintText: "Quantity",
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            getUserLocation();
                                          },
                                          icon:
                                              const Icon(Icons.location_city)),
                                      // prefixIcon: Padding(
                                      //   padding: EdgeInsets.only(
                                      //       top:
                                      //           15), // add padding to adjust icon
                                      //   child: Icon(Icons.location_city),
                                      // ),

                                      labelText: 'Quantity',
                                    ),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter your Adress';
                                      }
                                      return null;
                                    },
                                    controller: adresscontroller,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Enter your Adress',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    ref.read(orderProvider.notifier).sendOrder(
                                        'userId',
                                        'productId:${list[index].productId}',
                                        1,
                                        'address:${adresscontroller.value.text}',
                                        // ignore: void_checks
                                        'submit');

                                    if (Form.of(context).validate()) {
                                      String quantity =
                                          quantityController.value.text.trim();
                                      String adress =
                                          adresscontroller.value.text.trim();
                                      quantity;
                                      adress;
                                    } // Get the quantity entered in the text field
                                    //   String quantity = quantityController.text;

                                    // Process the order, e.g., send to Firebase
                                    // ...

                                    // Close the dialog

                                    Navigator.pop(context);
                                  },
                                  child: const Text('Confirm Order'),
                                ),
                              ],
                            ),
                          );
                          const Icon(Icons.delete);
                        },
                        child: Card(
                            color: Colors.green,
                            elevation: 2,
                            margin: const EdgeInsets.all(5),
                            child: Row(children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.transparent),
                                    color: Colors.green),
                                child: CircleAvatar(
                                  foregroundImage:
                                      NetworkImage(list[index].img),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                                width: 10,
                              ),
                              // const Spacer(),
                              Text(
                                'Product_Name:${list[index].name}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              const Spacer(),
                              Text(
                                'R.s:${list[index].price.toString()}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () async {
                                  // Show a dialog to confirm delete
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: Text(
                                          'Are you sure you want to delete ${list[index].name}?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // Close the dialog
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                // Delete the item and close the dialog
                                                await FirebaseFirestore.instance
                                                    .collection('carts')
                                                    .doc('userId')
                                                    .collection('items')
                                                    .doc(cartItems[index].id)
                                                    .delete();

                                                // ignore: use_build_context_synchronously
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Delete'))
                                        ]),
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ])),
                      );
                    });
              }
            }));
  }
}

class OrderErrorStateWidget extends ConsumerWidget {
  const OrderErrorStateWidget({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        color: Colors.red,
        child: Text(errorMessage),
      ),
    );
  }
}
// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});



  

//   @override
//   Widget build(BuildContext context) {
  
//     
//   }
// }
