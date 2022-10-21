import 'package:e_commerce_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final bool passwordStars;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final void Function(String value) onChanged;
  final void Function(String value)? onSubmitted;
  final IconData icon;
  final bool showEye;

  const CustomInputField({
    Key? key,
    required this.hintText,
    this.focusNode,
    required this.onChanged,
    this.onSubmitted,
    this.passwordStars = false,
    required this.textInputAction,
    required this.icon,
    this.showEye = false,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool hidePassword = false;

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
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 20,
            child: Icon(
              widget.icon,
              color: Color(0xFF595858),
            ),
          ),
          TextField(
            textInputAction: widget.textInputAction,
            obscureText: widget.passwordStars
                ? hidePassword
                    ? true
                    : false
                : false,
            onSubmitted: widget.onSubmitted,
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              border: InputBorder.none,
              hintText: widget.hintText,
              contentPadding:
                  //EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  EdgeInsets.fromLTRB(55, 18, 24, 18),
            ),
            style: Constants.regularDarkText,
          ),
          if (widget.showEye == true)
            Positioned(
              right: 15,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    hidePassword = !(hidePassword);
                  });
                },
                child: Icon(
                  hidePassword == false
                      ? CupertinoIcons.eye_slash_fill
                      : CupertinoIcons.eye_fill,
                  color: Color(0xFF595858),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
