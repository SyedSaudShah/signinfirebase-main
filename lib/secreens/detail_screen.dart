import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:signinfirebase/addcart/cart.dart';
import 'package:signinfirebase/riverpod/addcartProvider.dart';
import 'package:signinfirebase/riverpod/addcartState.dart';
import 'package:signinfirebase/secreens/cart_screen.dart';

class DetailScfreen extends ConsumerWidget {
  const DetailScfreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider.notifier);
    return Scaffold(
      body: Builder(
        builder: (context) {
          if (cartState is CartLoadingState) {
            return const CartLoadingStateWidget();
          } else if (cartState is CartLoadedState) {
            return const Text('Loaded State');
          } else {
            return CartErrorWidget(error: (cartState as CartErrorWidget).error);
          }
        },
      ),
    );
  }
}

class CartLoadingStateWidget extends ConsumerWidget {
  const CartLoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.cyanAccent,
    ));
  }
}

// ignore: must_be_immutable
class CartLoadedStateWidget extends ConsumerStatefulWidget {
  CartLoadedStateWidget(
      {super.key,
      //  required this.getImage,
      required this.img,
      required this.productId,
      required this.name,
      required this.price,
      required this.quantity});
  // GetImage getImage;
  String img;
  String name;
  num price;
  num quantity;
  String productId;
  @override
  ConsumerState<CartLoadedStateWidget> createState() =>
      _CartLoadedStateWidget();
}

class _CartLoadedStateWidget extends ConsumerState<CartLoadedStateWidget> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final cartState = ref.watch(cartProvider.notifier);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderLoadedState(),
                      ));
                },
                icon: const Icon(Icons.shopping_bag))
          ],
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.greenAccent[400],
          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          title: const Text("Detail Screen"),
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
        body: Stack(children: [
          Positioned(
              top: 00,
              bottom: 00,
              right: 00,
              left: 00,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(40)),
              )),
          Positioned(
              top: 230,
              bottom: 00,
              left: 00,
              right: 00,
              child: Container(
                height: height * 1,
                width: width * 1,
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
              )),
          Positioned(
              top: 4,
              bottom: 350,
              right: 00,
              left: 00,
              child: CircleAvatar(
                foregroundImage: NetworkImage(widget.img),
                child: Container(
                  height: height * 1,
                  width: width * 1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: width / 5),
                    // color: Colors.black26,
                    shape: BoxShape.circle,
                    // image:
                    //     DecorationImage(image: NetworkImage(widget.img)
                    //     )
                  ),
                ),
              )),
          Positioned(
            bottom: 100,
            left: 40,
            right: 40,
            top: 500,
            child: Center(
              child: Container(
                  height: height * 1,
                  width: width * 1,
                  decoration: const BoxDecoration(),
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontStyle: FontStyle.italic),
                  )),
            ),
          ),
          Positioned(
            bottom: 00,
            left: 40,
            right: 40,
            top: 600,
            child: Center(
              child: Container(
                  height: height * 1,
                  width: width * 1,
                  decoration: const BoxDecoration(),
                  child: Text(
                    widget.price.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontStyle: FontStyle.italic),
                  )),
            ),
          ),
          Positioned(
            top: 700,
            bottom: 00,
            left: 100,
            right: 100,
            child: Center(
              child: InkWell(
                onTap: () {
                  ref
                      .read(cartProvider.notifier)
                      .addTocart(Cartitem(
                        img: widget.img,
                        name: widget.name,
                        price: widget.price,
                        quantity: 1,
                        productId: widget.productId,
                      ))
                      .then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderLoadedState(),
                          )));
                },
                child: Card(
                  color: Colors.white,
                  child: Container(
                    // height: height * 1,
                    // width: width * 1,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent)),
                    child: const Text('Add to cart',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: height * 1,
            width: width * 1,
          )
        ]));
  }
}

class HomeErrorStateStateWidget extends ConsumerWidget {
  const HomeErrorStateStateWidget({
    super.key,
    required this.errormessage,
  });
  final String errormessage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(errormessage);
  }
}

class CartErrorWidget extends ConsumerWidget {
  const CartErrorWidget({super.key, required this.error});
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(error);
  }
}
//  Column(
//           children: [
//             Row(children: [
//               Center(
//                 child: Padding(
//                     padding: const EdgeInsets.only(left: 150, top: 10),
//                     child: SizedBox(
//                       height: height / 5.5,
//                       child: Text(
//                         widget.name,
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 30,
//                             fontStyle: FontStyle.italic),
//                       ),
//                     )),
//               )
//             ]),
//             Stack(children: [
//               Center(
//                 child: SizedBox(
//                   height: height / 2,
//                   width: width / 1,
//                   child: Card(
//                     color: Colors.green,
//                     child: Container(
//                       decoration: const BoxDecoration(),
//                       height: height / 2,
//                       width: width / 1,
//                       // decoration: BoxDecoration(border: Border.all()),
//                       child: CircleAvatar(
//                         foregroundImage: NetworkImage(
//                           widget.img,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//             Container(
//               decoration: const BoxDecoration(),
//               alignment: Alignment.center,
//               child: Center(
//                   child: Text(
//                 widget.name,
//                 style: const TextStyle(
//                     letterSpacing: 5,
//                     fontStyle: FontStyle.italic,
//                     fontSize: 25),
//               )),
//             ),
//             const SizedBox(
//               height: 10,
//               width: 10,
//             ),
//             Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50),
//                   // bottomRight: Radius.circular(50),
//                   bottomRight: Radius.circular(50),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.white12,
//                     offset: Offset(9, 9),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               alignment: Alignment.center,
//               child: Center(
//                   child: Text(
//                 widget.price.toString(),
//                 style: const TextStyle(
//                     letterSpacing: 5,
//                     fontStyle: FontStyle.italic,
//                     fontSize: 30),
//               )),
//             ),
//             const SizedBox(),
//             SizedBox(
//                 child: ElevatedButton(
//                     onPressed: () {
//                       ElevatedButton.styleFrom(
//                           shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   topRight: Radius.elliptical(10, 40))));

//                       ref
//                           .read(cartProvider.notifier)
//                           .addTocart(Cartitem(
//                             img: widget.img,
//                             name: widget.name,
//                             price: widget.price,
//                             quantity: 1,
//                             productId: widget.productId,
//                           ))
//                           .then((value) => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const CartScreen(),
//                               )));
//                     },
//                     child: const Text('add to cart'))),
//           ],
//         ),