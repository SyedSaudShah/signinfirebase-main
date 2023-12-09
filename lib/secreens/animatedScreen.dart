// ignore: file_names

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
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyImageScreen(),
//     );
//   }
// }

// class MyImageScreen extends StatefulWidget {
//   @override
//   _MyImageScreenState createState() => _MyImageScreenState();
// }

// class _MyImageScreenState extends State<MyImageScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );

//     _animation = Tween<double>(
//       begin: 0.5, // Starting scale factor
//       end: 1.0, // Ending scale factor
//     ).animate(_animationController);

//     _animationController.forward(); // Start the animation
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String imageUrl;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Animated Image Example'),
//       ),
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _animation,
//           builder: (context, child) {
//             return Transform.scale(
//               scale: _animation.value,
//               child: Image.network(
//                 'https://example.com/your-image.jpg',
//                 width: 200.0,
//                 height: 200.0,
//                 fit: BoxFit.cover,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
// }
