import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signinfirebase/addcart/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    return FirebaseFirestore.instance
        .collection('carts')
        .doc('userId')
        .collection('items')
        .get();
  }

  @override
  Widget build(BuildContext context) {
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

                      return Card(
                          color: Colors.green,
                          elevation: 2,
                          margin: const EdgeInsets.all(5),
                          child: Row(children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  color: Colors.green),
                              child: CircleAvatar(
                                foregroundImage: NetworkImage(list[index].img),
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
                          ]));
                    });
              }
            }));
  }
}
