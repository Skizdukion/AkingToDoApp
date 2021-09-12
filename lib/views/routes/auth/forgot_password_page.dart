import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/views/routes/auth/reset_password_page.dart';
import 'package:todo_app/views/widgets/auth_form_widgets.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: buildInitialInput(),
          appBar: AppBar(
              backgroundColor: Colors.white10,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black))),
    );
  }

  Widget buidLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  Widget buildInitialInput() {
    return Padding(
      padding: EdgeInsets.only(left: 30.h, top: 20.h, right: 30.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text('Forgot Password',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10.h),
          Text(
              'Please enter your email below to receive your password reset instructions',
              style: TextStyle(
                  color: Color.fromRGBO(155, 155, 155, 1), fontSize: 16)),
          SizedBox(height: 50.h),
          FormInputField(),
        ],
      ),
    );
  }
}

class FormInputField extends StatefulWidget {
  const FormInputField({Key? key}) : super(key: key);

  @override
  _FormInputFieldState createState() => _FormInputFieldState();
}

class _FormInputFieldState extends State<FormInputField> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VisibleInputField(
          controller: _emailController,
          labelText: 'Username',
          hintText: 'Enter your email as user name',
          type: VisibleInputFieldType.email,
        ),
        SizedBox(height: 50.h),
        StrechButton(
          text: 'Send Request',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResetPasswordPage()));
          },
          buttonStyle: AppButtonDecoration.authenticate2,
        ),
      ],
    );
  }
}
