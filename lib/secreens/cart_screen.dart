// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:signinfirebase/addcart/cart.dart';

// class CartScreen extends StatefulWidget {
//   CartScreen({Key? key}) : super(key: key);

//   @override
//   State<CartScreen> createState() => _MyAppState();
// }

// class _MyAppState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.blue,
//               title: const Text('Cart Screen'),
//             ),
//             body: StreamBuilder(
//               stream:
//                   FirebaseFirestore.instance.collection('carts').snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(
//                     child: Text('Cart is empty.'),
//                   );
//                 } else if (snapshot.hasData) {
//                   return ListView.builder(
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         Cartitem cartitem =
//                             Cartitem.fromMap(snapshot.data!.docs[index].data());
//                         cartitem.img.toString();
//                         Text(cartitem.name[index].toString());
//                         Text(cartitem.price.toString());
//                         return ListView(
//                           children: snapshot.data!.docs.map((document) {
//                             var data = document.data() as Map<String, dynamic>;
//                             return ListTile(
//                               title: Text(data['item_name']),
//                               subtitle: Text('Price: ${data['item_price']}'),
//                             );
//                           }).toList(),
//                         );
//                       });
//                 } else {
//                   return const SizedBox();
//                 }
//               },
//             )));
//   }
// }
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
        title: const Text('Cart'),
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
            print('Firestore Data: ${snapshot.data?.docs}');
            var cartItems = snapshot.data!.docs;
            // .map((doc) =>
            //     Cartitem.fromMap(doc.data() as Map<String, dynamic>))
            // .toList();
            List<Cartitem> list = cartItems
                .map((e) => Cartitem.fromMap(e.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                print('firsttttttttttttttttttttttttttttttttt${cartItems}');
                //  return Text(list[index].name);
                return Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(), color: Colors.amber),
                          child: Image.network(
                            list[index].img,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(list[index].name),
                    Spacer(),
                    Text(list[index].price.toString()),
                    Spacer(),
                    Text(list[index].quantity.toString())
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:signinfirebase/addcart/cart.dart';

// // ignore: must_be_immutable
// class CartScreen extends StatelessWidget {
//   Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
//     Stream<QuerySnapshot<Map<String, dynamic>>> data = FirebaseFirestore
//         .instance
//         .collection('carts')
//         .doc()
//         .collection('items')
//         .snapshots();
//     print('dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$data');
//     return data;
//   }

//   final String userId = 'your_user_id';

//   CartScreen({super.key}); // Replace with the actual user's ID

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: getData(),
//         builder: (context, snapshot) {
//           // Map the documents to CartItem objects
//           var cartItems = snapshot.data!.docs
//               .map((doc) => Cartitem.fromJson(userId))
//               .toList();
//           print('?????????????????????????????????????????${snapshot.data}');
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 print(
//                     'carrt itemsssssssssssssssssssssssssssssssssssssssssssssssssssssssss4$cartItems');
//                 return Column(
//                   children: [
//                     Image(
//                       image: NetworkImage(cartItems[index].img),
//                     ),
//                     Text(cartItems[index].name),
//                     Text(cartItems[index].price.toString()),
//                     Text(cartItems[index].quantity.toString()),
//                   ],
//                 );
//               },
//             );
//           } else {
//             return Text("gfdsdfgdsfgds");
//           }
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:signinfirebase/addcart/cart.dart';

// class CartScreen extends StatelessWidget {
//   final String userId = 'your_user_id'; // Replace with the actual user's ID

//   Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
//     Stream<QuerySnapshot<Map<String, dynamic>>> data = FirebaseFirestore
//         .instance
//         .collection('carts')
//         .doc(userId)
//         .collection('items')
//         .snapshots();
//     print('dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$data');
//     return data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: getData(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasData) {
//             var cartItems = snapshot.data!.docs
//                 .map((doc) =>
//                     Cartitem.fromMap(doc.data() as Map<String, dynamic>))
//                 .toList();

//             return ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     Text(cartItems[index].name),
//                     Text(cartItems[index].price.toString()),
//                     Text(cartItems[index].quantity.toString()),
//                   ],
//                 );
//               },
//             );
//           } else {
//             return const Text("Something went wrong");
//           }
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//       ),
//       body: ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Row(
//             children: [
//               Image.asset('assests/images/chikn.png'),
//               ListTile(
//                 title: Text('data'),
//                 leading: Text('data'),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
