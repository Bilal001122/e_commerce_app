import 'package:e_commerce_app/screens/nav_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}

// final List<Widget> screens = [
//   HomeScreen(
//     key: PageStorageKey('home'),
//   ),
//   Scaffold(body: Center(child: Text('1'))),
//   Scaffold(body: Center(child: Text('2'))),
//   Scaffold(body: Center(child: Text('3'))),
// ];
