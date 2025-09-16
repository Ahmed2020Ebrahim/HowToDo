import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:how_to_do/app.dart';
import 'featuers/home/model/task_model.dart';
import 'featuers/home/model/task_priority.dart';
import 'utils/helpers/hive_helper.dart';
import 'utils/helpers/shared_pref_helper.dart';

void main() async {
  // Ensure widget binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  await SharedPrefHelper.instance.init();

  // Initialize Hive
  await HiveHelper.instance.init();

  // Register adapters
  Hive.registerAdapter(PriorityAdapter());
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('tasks');

  // Lock the app in portrait only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // run the app
  runApp(const App());
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: const MyAnimatedBox());
//   }
// }

// //Todo : [Example] MyAnimatedBox {AnimatedContainer}
// class MyAnimatedBox extends StatefulWidget {
//   const MyAnimatedBox({super.key});

//   @override
//   State<MyAnimatedBox> createState() => _MyAnimatedBoxState();
// }

// class _MyAnimatedBoxState extends State<MyAnimatedBox> {
//   double size = 100;

//   double firstWidth = 150;
//   double firstHeight = 75;

//   Color containerColor = Colors.blue;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Animated Box')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             //AnimatedContainer Example
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   size = size == 100 ? 200 : 100;
//                 });
//               },
//               child: AnimatedContainer(
//                 width: size,
//                 height: size,
//                 duration: const Duration(seconds: 1),
//                 curve: Curves.easeInOut,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//             ),

//             //space
//             SizedBox(height: 50),

//             //AnimatedCrossFade Example
//             ToggleButton(),

//             //space
//             SizedBox(height: 50),

//             //Divider
//             Divider(height: 20, color: Colors.black),
//             SizedBox(height: 10),
//             Text("AnimatedOpacity Example"),

//             //AnimatedOpacity Example
//             OpacityToggleExample(),

//             SizedBox(height: 50),

//             PaymentOperation(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// //Todo : [Example] toogle Button {AnimatedCrossFade}
// class ToggleButton extends StatefulWidget {
//   const ToggleButton({super.key});

//   @override
//   State<ToggleButton> createState() => _ToggleButtonState();
// }

// class _ToggleButtonState extends State<ToggleButton> {
//   bool showFirst = true;

//   void toggle() {
//     setState(() {
//       showFirst = !showFirst;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AnimatedCrossFade(
//         duration: const Duration(seconds: 1),
//         firstChild: GestureDetector(
//           onTap: toggle,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//             decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),

//             child: const Text('Pay Now', style: TextStyle(fontSize: 20, color: Colors.white)),
//           ),
//         ),
//         secondChild: GestureDetector(
//           onTap: toggle,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//             decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),

//             child: const Text('Try Again', style: TextStyle(fontSize: 20, color: Colors.white)),
//           ),
//         ),
//         crossFadeState: showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
//         firstCurve: Curves.easeIn,
//         secondCurve: Curves.easeIn,
//       ),
//     );
//   }
// }

// //
// //

// //Todo : [Example] opacity toggle {AnimatedOpacity}
// class OpacityToggleExample extends StatefulWidget {
//   const OpacityToggleExample({super.key});

//   @override
//   State<OpacityToggleExample> createState() => _OpacityToggleExampleState();
// }

// class _OpacityToggleExampleState extends State<OpacityToggleExample> {
//   bool visible = true;
//   void toggleOpacity() {
//     setState(() {
//       visible = !visible;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           AnimatedOpacity(
//             opacity: visible ? 1.0 : 0.0,
//             duration: const Duration(seconds: 1),
//             curve: Curves.easeInOut,
//             child: Container(width: 150, height: 150, color: Colors.blue),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(onPressed: toggleOpacity, child: Text(visible ? 'Hide Box' : 'Show Box')),
//         ],
//       ),
//     );
//   }
// }

// class PaymentOperation extends StatefulWidget {
//   const PaymentOperation({super.key});

//   @override
//   State<PaymentOperation> createState() => _PaymentOperationState();
// }

// class _PaymentOperationState extends State<PaymentOperation> {
//   bool isLoading = false;
//   bool showCheck = false;
//   bool scaleUp = false;

//   void onPayPressed() async {
//     setState(() => isLoading = true);

//     await Future.delayed(const Duration(seconds: 1));
//     setState(() {
//       isLoading = false;
//       showCheck = true;
//     });

//     await Future.delayed(const Duration(milliseconds: 500));
//     setState(() => scaleUp = true);

//     await Future.delayed(const Duration(milliseconds: 300));

//     Navigator.push(context, MaterialPageRoute(builder: (_) => const SuccessScreen()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//         onPressed: isLoading || showCheck ? null : onPayPressed,
//         child: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
//           child:
//               !isLoading && !showCheck
//                   ? const Text("Pay Now", key: ValueKey('text'), style: TextStyle(fontSize: 18))
//                   : isLoading
//                   ? const SizedBox(
//                     key: ValueKey('loader'),
//                     height: 24,
//                     width: 24,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 3,
//                       valueColor: AlwaysStoppedAnimation(Colors.white),
//                     ),
//                   )
//                   : AnimatedScale(
//                     key: const ValueKey('check'),
//                     scale: scaleUp ? 1.5 : 1.0,
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeOutBack,
//                     child: const Hero(
//                       tag: 'success-check',
//                       child: Icon(Icons.check, color: Colors.white, size: 28),
//                     ),
//                   ),
//         ),
//       ),
//     );
//   }
// }

// class SuccessScreen extends StatelessWidget {
//   const SuccessScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       appBar: AppBar(title: const Text('Success')),
//       body: Center(
//         child: Hero(tag: 'success-check', child: Icon(Icons.check, color: Colors.green, size: 100)),
//       ),
//     );
//   }
// }
