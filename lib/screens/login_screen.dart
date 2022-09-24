import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_input.dart';
import 'package:e_commerce_app/models/user.dart' as model_user;
import 'package:provider/provider.dart';
import 'package:e_commerce_app/services/authentication.dart';

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

  bool loginScreenFormLoading = false;
  late String email;
  late String password;
  late FocusNode passwordFocusNode;
  late FocusNode emailFocusNode;
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<model_user.User?>(context);
    passwordFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  CustomInputField(
                    textInputAction: TextInputAction.next,
                    hintText: 'Email',
                    onChanged: (value) {
                      email = value;
                    },
                    onSubmitted: (value) {
                      passwordFocusNode.requestFocus();
                    },
                  ),
                  CustomInputField(
                    textInputAction: TextInputAction.done,
                    hintText: 'Password ...',
                    passwordStars: true,
                    onChanged: (value) {
                      password = value;
                    },
                    focusNode: passwordFocusNode,
                  ),
                  CustomButton(
                    //isLoading: loginScreenFormLoading,
                    text: 'Login',
                    onPress: () async {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      result != null
                          ? Navigator.pushNamed(context, '/home')
                          : Navigator.pushNamed(context, '/login');
                      passwordFocusNode.dispose();
                      emailFocusNode.dispose();
                      //_alertDialogBuilder();
                      setState(() {
                        loginScreenFormLoading = true;
                      });
                    },
                  ),
                ],
              ),
              CustomButton(
                text: 'Create New Account',
                onPress: () {
                  Navigator.pushNamed(context, '/register');
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
