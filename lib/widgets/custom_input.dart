import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final bool passwordStars;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final void Function(String value) onChanged;
  final void Function(String value)? onSubmitted;
  const CustomInputField({
    Key? key,
    required this.hintText,
    this.focusNode,
    required this.onChanged,
    this.onSubmitted,
    this.passwordStars = false,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 40,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        textInputAction: textInputAction,
        obscureText: passwordStars ? true : false,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        focusNode: focusNode,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
