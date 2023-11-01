// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:signinfirebase/addcart/cart.dart';

// // class CartScreen extends StatefulWidget {
// //   CartScreen({Key? key}) : super(key: key);

// //   @override
// //   State<CartScreen> createState() => _MyAppState();
// // }

// // class _MyAppState extends State<CartScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         home: Scaffold(
// //             appBar: AppBar(
// //               backgroundColor: Colors.blue,
// //               title: const Text('Cart Screen'),
// //             ),
// //             body: StreamBuilder(
// //               stream:
// //                   FirebaseFirestore.instance.collection('carts').snapshots(),
// //               builder: (context, snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return const Center(child: CircularProgressIndicator());
// //                 } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //                   return const Center(
// //                     child: Text('Cart is empty.'),
// //                   );
// //                 } else if (snapshot.hasData) {
// //                   return ListView.builder(
// //                       itemCount: snapshot.data!.docs.length,
// //                       itemBuilder: (context, index) {
// //                         Cartitem cartitem =
// //                             Cartitem.fromMap(snapshot.data!.docs[index].data());
// //                         cartitem.img.toString();
// //                         Text(cartitem.name[index].toString());
// //                         Text(cartitem.price.toString());
// //                         return ListView(
// //                           children: snapshot.data!.docs.map((document) {
// //                             var data = document.data() as Map<String, dynamic>;
// //                             return ListTile(
// //                               title: Text(data['item_name']),
// //                               subtitle: Text('Price: ${data['item_price']}'),
// //                             );
// //                           }).toList(),
// //                         );
// //                       });
// //                 } else {
// //                   return const SizedBox();
// //                 }
// //               },
// //             )));
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           // ignore: prefer_const_constructors
//           title: Text('Firebase Firestore Data Get Example'),
//         ),
//         body: Center(
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('your_collection_name')
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return const CircularProgressIndicator();
//               }

//               // Convert the snapshot data into a list of Map<String, dynamic>
//               List<Map<String, dynamic>> dataList = [];
//               for (var doc in snapshot.data!.docs) {
//                 dataList.add(doc.data());
//               }

//               // Use a ListView.builder to display the data
//               return ListView.builder(
//                 itemCount: dataList.length,
//                 itemBuilder: (context, index) {
//                   var data = dataList[index];
//                   return Column(
//                     children: [
//                       ListTile(
//                         title: Container(
//                           decoration: BoxDecoration(color: Colors.amber),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   data['field_name_1'],
//                                 ),
//                                 Text(
//                                   data['field_name_2'],
//                                 ),
//                                 Text(
//                                   data['field_name_3'],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 20,
//                       ),
//                       ElevatedButton(
//                           onPressed: () {}, child: const Text('Send oder'))
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signinfirebase/addcart/cart.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  Stream<QuerySnapshot<Map<String, dynamic>>> data = FirebaseFirestore.instance
      .collection('carts')
      .doc()
      .collection('items')
      .snapshots();

  final String userId = 'your_user_id';

  CartScreen({super.key}); // Replace with the actual user's ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: data,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Your cart is empty.'),
            );
          }

          // Map the documents to CartItem objects
          List<Cartitem> cartItems = snapshot.data!.docs
              .map((doc) => Cartitem.fromJson(userId))
              .toList();

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cartItems[index].name),
                subtitle: Text('Price: \$${cartItems[index].price.toString()}'),
                trailing: Text('Quantity: ${cartItems[index].quantity}'),
              );
            },
          );
        },
      ),
    );
  }
}
