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

class _HomeScreenState extends State<HomeScreen> {
  final foodFirestore =
      FirebaseFirestore.instance.collection('food').snapshots();
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
                                price: getImage.price.toString(),
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Center(
                            child: Expanded(
                              child: Card(
                                elevation: 3,
                                color: Colors.green,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: CircleAvatar(
                                    radius: 50,
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      alignment: const Alignment(20, 20),
                                      getImage.img,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              'Product:${getImage.name}',
                              style: const TextStyle(
                                // fontSize: 18,
                                // height: 2,
                                color: Colors.black,
                                //  backgroundColor: Colors.black12,
                                letterSpacing: 1,
                                //   decoration: TextDecoration.underline,
                                // decorationStyle: TextDecorationStyle.double,
                                decorationColor: Colors.red,
                                //  decorationThickness: 1.5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              'Rs:${getImage.price}',
                              style: const TextStyle(
                                fontSize: 18,
                                //height: 2,
                                color: Colors.black,
                                //   backgroundColor: Colors.black12,
                                letterSpacing: 1,
                                // decoration: TextDecoration.underline,
                                // decorationStyle: TextDecorationStyle.double,
                                decorationColor: Colors.black,
                                //  decorationThickness: 1.5,
                              ),
                            ),
                          ),
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
