import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/screens/nav_screen.dart';
import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/screens/register_screen.dart';
import 'package:e_commerce_app/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_commerce_app/models/user.dart' as model_user;
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<model_user.User?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(
                key: PageStorageKey('login'),
              ),
          '/register': (context) => RegisterScreen(
                key: PageStorageKey('register'),
              ),
          '/nav': (context) => NavScreen(
                key: PageStorageKey('nav'),
              ),
        },
      ),
    );
  }
}
