import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_input.dart';
import 'package:e_commerce_app/models/user.dart' as model_user;
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  'Create A New Account.',
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInputField(hintText: 'Email'),
                  CustomInputField(hintText: 'Password ...'),
                  CustomButton(
                    text: 'Create Account',
                    onPress: () {},
                  ),
                ],
              ),
              CustomButton(
                text: 'Back To Login',
                onPress: () {
                  Navigator.pop(context);
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
