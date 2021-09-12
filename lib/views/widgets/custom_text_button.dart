import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton({Key? key, required this.text, required this.onPress})
      : super(key: key);
  final String text;
  final Function onPress;

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget.onPress(),
      child: Text(
        widget.text,
        style: AppTextDecoration.whiteS18,
      ),
    );
  }
}
