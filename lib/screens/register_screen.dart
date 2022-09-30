import 'package:e_commerce_app/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_input.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool registerScreenFormLoading = false;
  late String email;
  late String password;
  late FocusNode passwordFocusNode;
  late FocusNode emailFocusNode;
  final AuthService _auth = AuthService();

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Error',
          ),
          content: Container(
            child: Text(error),
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
                  'Create A New Account.',
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
                    isLoading: registerScreenFormLoading,
                    text: 'Create Account',
                    onPress: () async {
                      setState(() {
                        registerScreenFormLoading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);

                      switch (result) {
                        case 'The password provided is too weak.':
                          {
                            _alertDialogBuilder(result);
                          }
                          break;
                        case 'The account already exists for that email.':
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
                        registerScreenFormLoading = false;
                      });
                    },
                  ),
                ],
              ),
              CustomButton(
                text: 'Back To Login',
                onPress: () {
                  Navigator.pushNamed(context, '/login');
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
