import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_input.dart';
import 'package:e_commerce_app/services/authentication.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loginScreenFormLoading = false;
  late String email;
  late String password;
  late FocusNode passwordFocusNode;
  late FocusNode emailFocusNode;
  final AuthService _auth = AuthService();

  // build an alert dialog
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Error',
          ),
          content: Text(error),
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
  void dispose() {
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    icon: Icons.email,
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
                    showEye: true,
                    icon: Icons.key,
                    textInputAction: TextInputAction.done,
                    hintText: 'Password ...',
                    passwordStars: true,
                    onChanged: (value) {
                      password = value;
                    },
                    focusNode: passwordFocusNode,
                  ),
                  CustomButton(
                    isLoading: loginScreenFormLoading,
                    text: 'Login',
                    onPress: () async {
                      setState(() {
                        loginScreenFormLoading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);

                      print(email + password);
                      switch (result) {
                        case 'No user found for that email.':
                          {
                            _alertDialogBuilder(result);
                          }
                          break;
                        case 'Wrong password provided for that user.':
                          {
                            _alertDialogBuilder(result);
                          }
                          break;
                        case 'The email is not valid.':
                          {
                            _alertDialogBuilder(result);
                          }
                          break;

                        case null:
                          {
                            _alertDialogBuilder(
                                'Please enter a valid informations.');
                          }
                          break;

                        default:
                          {
                            Navigator.pushNamed(context, '/nav');
                          }
                          break;
                      }
                      setState(() {
                        loginScreenFormLoading = false;
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
