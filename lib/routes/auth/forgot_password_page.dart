import 'package:flutter/material.dart';
import 'package:todo_app/routes/auth/reset_password_page.dart';
import 'package:todo_app/widgets/auth_form_widgets.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({ Key? key }) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
          Text('Forgot Password', style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Please enter your email below to receive your password reset instructions', style: TextStyle(color: Color.fromRGBO(155, 155, 155, 1), fontSize: 16)),
          SizedBox(height: 50),
          FormInputField(),
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisibleInputField(controller: _emailController, labelText: 'Username', hintText: 'Enter your email as user name', type: VisibleInputFieldType.email,),
          SizedBox(height: 50),
          SendRequestBtn(text: 'Send Request',formKey: _formKey, emailController: _emailController),
        ],
      ),
    );
  }
}


class SendRequestBtn extends StatelessWidget {
  SendRequestBtn({ Key? key, required this.text, required this.formKey, required this.emailController}) : super(key: key);
  final text;
  final formKey;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: ()async{
          if (formKey.currentState!.validate()){
            sendRequest(context, emailController.text);
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

  void sendRequest(BuildContext context, String email){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
  }
}

