import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_state.dart';
import 'package:todo_app/views/routes/introduction/introduction_page.dart';
import 'main/main_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is LoggeddUser) {
        return MainPage();
      } else
        return IntroductionPage();
    });
  }
}
