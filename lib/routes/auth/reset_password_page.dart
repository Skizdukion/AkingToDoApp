import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/routes/introduction/introduction_page.dart';
import 'package:todo_app/widgets/auth_form_widgets.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({ Key? key }) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
          Text('Reset password', style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
            'Reset code was sent to your email. Please enter the code and create new password', 
            style: TextStyle(color: Color.fromRGBO(155, 155, 155, 1), fontSize: 16)
          ),
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
          SizedBox(height: 40),
          ObscureInputField(
            controller: _passwordController, 
            labelText: 'New password', 
            hintText: 'Enter your password', 
            type: ObscureInputFieldType.password,
          ),
          SizedBox(height: 40),
          ObscureInputField(
            controller: _confirmPasswordController, 
            labelText: 'Confirm password', 
            hintText: 'Enter your confrim password', 
            type: ObscureInputFieldType.confirm_password,
            matchController: _passwordController,
          ),
          SizedBox(height: 50),
          ChangePassword(text: 'Change password',
            formKey: _formKey, 
            resetCodeController: _resetCodeController, 
            passwordController: _passwordController, 
            confirmPasswordController: _confirmPasswordController,
          ),
        ],
      ),
    );
  }
}


class ChangePassword extends StatelessWidget {
  ChangePassword({ Key? key, 
    required this.text, 
    required this.formKey, 
    required this.resetCodeController,
    required this.confirmPasswordController,
    required this.passwordController,
  }) : super(key: key);
  final text;
  final formKey;
  final TextEditingController resetCodeController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: ()async{
          if (formKey.currentState!.validate()){
            changePassword(context, resetCodeController.text, passwordController.text, confirmPasswordController.text);
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

  void changePassword(BuildContext context, String otp, String password, String confirmPassword){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ResetPasswordSuccessPage()), (r) => false);
  }
}

class ResetPasswordSuccessPage extends StatelessWidget {
  const ResetPasswordSuccessPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white10, elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
        body: Container(
          padding: EdgeInsets.fromLTRB(23, 0, 23, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Image(image: AssetImage('assets/reset_password_success.png')),
              SizedBox(height: 10,),
              Text('Successful!', style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              Text(
                'You have successfully change password.', 
                style: TextStyle(color: Color.fromRGBO(49, 49, 49, 1), fontSize: 16),
              ),
              Text(
                'Please use your new passwords when loggin', 
                style: TextStyle(color: Color.fromRGBO(49, 49, 49, 1), fontSize: 16),
              ),
              SizedBox(height: 30,),
              OKBtn(),
            ],
          ),
        )
      ),
    );
  }
}

class OKBtn extends StatelessWidget {
  OKBtn({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp()), (r) => false);
        },
        style: buttonStyleAuthPages,
        child: Text(
          'OK',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
