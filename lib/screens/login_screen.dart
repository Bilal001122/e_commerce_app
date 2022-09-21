import 'package:e_commerce_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_input.dart';
import 'package:e_commerce_app/models/user.dart' as model_user;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // build an alert dialog
  Future<void> _alertDialogBuilder() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Error',
          ),
          content: Container(
            child: Text('dfgdfgdfgdfg'),
          ),
          actions: [
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<model_user.User?>(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  'Welcome User,\n Login to your account',
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInputField(hintText: 'Email'),
                  CustomInputField(hintText: 'Password ...'),
                  CustomButton(
                    text: 'Login',
                    onPress: () {
                      _alertDialogBuilder();
                    },
                  ),
                ],
              ),
              CustomButton(
                text: 'Create New Account',
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                outlinedButton: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
