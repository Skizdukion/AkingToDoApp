import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_event.dart';
import 'package:todo_app/models/blocs/auth/auth_state.dart';
import 'package:todo_app/routes/auth/login_page.dart';
import 'package:todo_app/routes/main/main_page.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class IntroButton extends StatefulWidget {
  const IntroButton({ Key? key }) : super(key: key);

  @override
  _IntroButtonState createState() => _IntroButtonState();
}

class _IntroButtonState extends State<IntroButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: (){
                      // context.read<AuthBloc>().add(Register(email: 'emailController.text', password: 'passwordController.text'));
                    },
                    style: buttonAuthenticateStyle1, 
                    child: Text('Get started', style: TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Log In', style: TextStyle(color: Colors.white, fontSize: 18)),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}