import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_state.dart';
import 'package:todo_app/routes/introduction/intro_button.dart';
import 'package:todo_app/routes/introduction/introduction_page.dart';
import 'package:todo_app/routes/main/main_page.dart';
class Wrapper extends StatefulWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        if (state is AnonymousUser){
          return Scaffold(
            body: Container(
              child: Column(
                children: [
                  Expanded(flex: 70, child: IntroductionPage()),
                  Expanded(flex: 30, child:
                    Container(
                      child: IntroButton(),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/intro_below.png"),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          );
        }
        if (state is LoggeddUser) return MainPage();
        else return Text('Buggg');
      }
    );
  }
}


