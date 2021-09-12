import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/views/widgets/auth_form_widgets.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
      padding: EdgeInsets.only(left: 30.w, top: 20.h, right: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text('Reset password',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10.h),
          Text(
              'Reset code was sent to your email. Please enter the code and create new password',
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
  final _formKey = GlobalKey<FormState>();
  final _resetCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisibleInputField(
            controller: _resetCodeController,
            labelText: 'Reset code',
            hintText: 'Enter your number',
            type: VisibleInputFieldType.otp,
          ),
          SizedBox(height: 40.h),
          ObscureInputField(
            controller: _passwordController,
            labelText: 'New password',
            hintText: 'Enter your password',
            type: ObscureInputFieldType.password,
          ),
          SizedBox(height: 40.h),
          ObscureInputField(
            controller: _confirmPasswordController,
            labelText: 'Confirm password',
            hintText: 'Enter your confrim password',
            type: ObscureInputFieldType.confirm_password,
            matchController: _passwordController,
          ),
          SizedBox(height: 50.h),
          StrechButton(
              text: 'Change password',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPasswordSuccessPage()),
                    (r) => false);
              },
              buttonStyle: AppButtonDecoration.authenticate2)
        ],
      ),
    );
  }
}

class ResetPasswordSuccessPage extends StatelessWidget {
  const ResetPasswordSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              backgroundColor: Colors.white10,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black)),
          body: Container(
            padding: EdgeInsets.fromLTRB(23.w, 0, 23.w, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150.h,
                ),
                Image(image: AssetImage('assets/reset_password_success.png')),
                SizedBox(
                  height: 10.h,
                ),
                Text('Successful!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'You have successfully change password.',
                  style: TextStyle(
                      color: Color.fromRGBO(49, 49, 49, 1), fontSize: 16),
                ),
                Text(
                  'Please use your new passwords when loggin',
                  style: TextStyle(
                      color: Color.fromRGBO(49, 49, 49, 1), fontSize: 16),
                ),
                SizedBox(
                  height: 30.h,
                ),
                StrechButton(
                    text: 'OK',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                          (r) => false);
                    },
                    buttonStyle: AppButtonDecoration.authenticate2)
              ],
            ),
          )),
    );
  }
}
