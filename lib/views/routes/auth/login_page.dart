import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_event.dart';
import 'package:todo_app/logic/blocs/auth/auth_state.dart';
import 'package:todo_app/views/routes/auth/forgot_password_page.dart';
import 'package:todo_app/views/utils/extension/snack_bar.dart';
import 'package:todo_app/views/widgets/auth_form_widgets.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is LoggeddUser) {
        Navigator.pop(context);
      }
      if (state is VerifyFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            ExpandedSnackBar.failureSnackBar(context, state.errorString));
      }
    }, builder: (context, state) {
      if (state is AuthLoading)
        return buidLoading();
      else
        return SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: buildInitialInput(),
              appBar: AppBar(
                  backgroundColor: Colors.white10,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black))),
        );
    });
  }

  Widget buidLoading() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
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
          Text('Welcome back',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10.h),
          Text('Sign in to continue',
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
  final _passwordController = TextEditingController();

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
        SizedBox(height: 40.h),
        ObscureInputField(
          controller: _passwordController,
          labelText: 'Password',
          hintText: 'Enter your password',
          type: ObscureInputFieldType.password,
        ),
        ForgotTextButton(),
        SizedBox(height: 50.h),
        StrechButton(
          text: 'Login',
          onPressed: () {
            context.read<AuthBloc>().add(Login(
                email: _emailController.text,
                password: _passwordController.text));
          },
          buttonStyle: AppButtonDecoration.authenticate2,
        ),
      ],
    );
  }
}

class ForgotTextButton extends StatelessWidget {
  const ForgotTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
          },
          child: Text(
            'Forgot pasword',
            style:
                TextStyle(fontSize: 18, color: Color.fromRGBO(49, 49, 49, 1)),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }
}
