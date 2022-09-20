import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/models/user.dart' as model_user;
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<model_user.User?>(context);

    if (user == null) {
      return RegisterScreen();
    } else {
      return LoginScreen();
    }
  }
}
