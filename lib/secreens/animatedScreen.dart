
// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   @override
//   void initState() {
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 5000),
//       vsync: this,
//     );
//     _controller.forward();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Transform(
//                 alignment: FractionalOffset.centerLeft,
//                 transform: Matrix4.identity()
//                   ..setEntry(2, 3, 0.001)
//                   ..rotateX(6)
//                   ..rotateY(6),
//                 child: RotationTransition(
//                   turns: _controller,
//                   child:
//                       const Image(image: AssetImage('assets/images/chikn.png')),
//                 )),
//             // ElevatedButton(
//             //   child: Text("go"),
//             //   onPressed: () =>
//             // ),
//             // ElevatedButton(
//             //   child: Text("reset"),
//             //   onPressed: () => _controller.reset(),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
