import 'package:flutter/material.dart';
import 'package:todo_app/routes/auth/forgot_password_page.dart';
import 'package:todo_app/widgets/auth_form_widgets.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildInitialInput(),
        appBar: AppBar(backgroundColor: Colors.white10, elevation: 0, iconTheme: IconThemeData(color: Colors.black))
      ),
    );
  }

  Widget buidLoading(){
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  Widget buildInitialInput(){
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text('Welcome back', style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Sign in to continue', style: TextStyle(color: Color.fromRGBO(155, 155, 155, 1), fontSize: 16)),
          SizedBox(height: 50),
          FormInputField(),
          // RegisterNav(toggleView: toggleView),
        ],
      ),
    );
  }
}


class FormInputField extends StatefulWidget {
  const FormInputField({ Key? key }) : super(key: key);

  @override
  _FormInputFieldState createState() => _FormInputFieldState();
}

class _FormInputFieldState extends State<FormInputField> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisibleInputField(
            controller: _emailController, 
            labelText: 'Username',
            hintText: 'Enter your email as user name', 
            type: VisibleInputFieldType.email,
          ),
          SizedBox(height: 40),
          ObscureInputField(
            controller: _passwordController, 
            labelText: 'Password', 
            hintText: 'Enter your password', 
            type: ObscureInputFieldType.password,
          ),
          ForgotTextButton(),
          SizedBox(height: 50),
          LoginButton(text: 'Log In',formKey:  _formKey, emailController: _emailController, passwordController: _passwordController),
        ],
      ),
    );
  }
}

class ForgotTextButton extends StatelessWidget {
  const ForgotTextButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row( 
      children: [TextButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
        },
        child: 
          Text(
            'Forgot pasword',
            style: TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(49, 49, 49, 1)
            ),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }
}

class LoginButton extends StatelessWidget {
  LoginButton({ Key? key, 
    required this.text, 
    required this.formKey, 
    required this.emailController, 
    required this.passwordController
  }) : super(key: key);
  final text;
  final formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: ()async{
          if (formKey.currentState!.validate()){
            loginWithEmail(context, emailController.text, passwordController.text);
          }
        },
        style: buttonStyleAuthPages,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void loginWithEmail(BuildContext context, String email, String password){
    
  }
}


