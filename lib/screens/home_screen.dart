import 'package:e_commerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomActionBar(
          text: 'Home',
        ),
        Center(
          child: Text(
            'Home',
          ),
        ),
      ],
    );
  }
}
