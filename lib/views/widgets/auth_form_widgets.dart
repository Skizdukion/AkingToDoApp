import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/input_decoration.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';

enum VisibleInputFieldType {
  email,
  otp,
}

enum ObscureInputFieldType {
  password,
  confirm_password,
}

class VisibleInputField extends StatelessWidget {
  const VisibleInputField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.type})
      : super(key: key);

  final controller;
  final labelText;
  final hintText;
  final VisibleInputFieldType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: AppTextDecoration.labelInAuthPages),
        TextFormField(
          controller: controller,
          validator: (val) {
            // if (val == null || val.isEmpty) {
            //   return 'This field is required';
            // }

            // if((type == VisibleInputFieldType.email)&&(val.isValidEmail() == false))
            // {
            //   return 'Username is not valid, it must be an email';
            // }

            // if((type == VisibleInputFieldType.otp)&&(val.isValidOTP() == false))
            // {
            //   return 'Reset code is not valid, it must contain 6 numbers';
            // }
          },
          decoration: AppInputDecoration.authPages.copyWith(
            hintText: hintText,
          ),
          style: TextStyle(color: Color.fromRGBO(49, 49, 49, 1), fontSize: 16),
        ),
      ],
    );
  }
}

class ObscureInputField extends StatelessWidget {
  ObscureInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.type,
    this.matchController,
  }) : super(key: key);

  final controller;
  final labelText;
  final hintText;
  final TextEditingController? matchController;
  final ObscureInputFieldType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: AppTextDecoration.labelInAuthPages),
        TextFormField(
          controller: controller,
          validator: (val) {
            // if (val == null || val.length < 6) {
            //   return 'This field must contain at least 6 characters';
            // }

            // if ((type == ObscureInputFieldType.confirm_password)&&(matchController!.text != val)){
            //   return 'Password mismatch please try again';
            // }
          },
          decoration: AppInputDecoration.authPages.copyWith(
            hintText: hintText,
          ),
          style: TextStyle(color: Color.fromRGBO(49, 49, 49, 1), fontSize: 16),
          obscureText: true,
        ),
      ],
    );
  }
}
