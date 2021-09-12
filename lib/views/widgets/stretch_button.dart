import 'package:flutter/material.dart';

class StrechButton extends StatelessWidget {
  const StrechButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.buttonStyle,
      this.horizontalPadding = 0,
      this.textColor = Colors.white})
      : super(key: key);
  final String text;
  final Function onPressed;
  final ButtonStyle buttonStyle;
  final double horizontalPadding;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: () => onPressed(),
          style: buttonStyle,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
