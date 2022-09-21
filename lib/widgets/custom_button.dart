import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final bool outlinedButton;
  final bool isLoading;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPress,
      this.outlinedButton = false,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          primary: outlinedButton ? Colors.black12 : Colors.white,
          maximumSize: Size.fromHeight(60),
          backgroundColor: outlinedButton ? Colors.transparent : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              width: 2,
              color: Colors.black,
            ),
          ),
        ),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading ? false : true,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: outlinedButton ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading ? true : false,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
