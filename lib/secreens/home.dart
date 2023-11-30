import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signinfirebase/Modelclass/imgModel.dart';
import 'package:signinfirebase/secreens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api

  createState() => _HomeScreenState();
}

final foodFirestore = FirebaseFirestore.instance.collection('food').snapshots();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          title: const Text("Fast Food"),
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
          backgroundColor: Colors.greenAccent[400],
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: foodFirestore,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    GetImage getImage =
                        GetImage.fromMap(snapshot.data!.docs[index].data());
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartLoadedStateWidget(
                                img: getImage.img,
                                name: getImage.name,
                                price: getImage.price,
                                quantity: 1,
                                productId: getImage.id,
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Center(
                              child: SizedBox(
                            height: 140,
                            width: 130,
                            child: Card(
                              elevation: 50,
                              color: Colors.green,
                              child: Column(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                      20,
                                    )),
                                    child: CircleAvatar(
                                      foregroundImage: NetworkImage(
                                        getImage.img,
                                      ),
                                      // radius: 50,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: SizedBox(
                                      height: 20,
                                      child: Center(
                                        child: Text(
                                          'Product:${getImage.name}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            // height: 2,
                                            color: Colors.black,
                                            backgroundColor: Colors.black12,
                                            //  letterSpacing: 1,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationStyle:
                                                TextDecorationStyle.double,
                                            decorationColor: Colors.black12,
                                            decorationThickness: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: SizedBox(
                                      height: 20,
                                      child: Center(
                                        child: Text(
                                          'Rs:${getImage.price}',
                                          style: const TextStyle(
                                            fontSize: 15,

                                            color: Colors.black,
                                            backgroundColor: Colors.black12,
                                            //letterSpacing: 1,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationStyle:
                                                TextDecorationStyle.double,
                                            decorationColor: Colors.black12,
                                            decorationThickness: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            }));
  }
}
