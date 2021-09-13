import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_state.dart';
import 'package:todo_app/views/routes/auth/login_page.dart';
import 'package:todo_app/views/widgets/custom_text_button.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroButton extends StatefulWidget {
  const IntroButton({Key? key}) : super(key: key);

  @override
  _IntroButtonState createState() => _IntroButtonState();
}

class _IntroButtonState extends State<IntroButton> {

  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              StrechButton(
                text: 'Get started',
                onPressed: () {},
                buttonStyle: AppButtonDecoration.authenticate1,
                textColor: Colors.black,
              ),
              SizedBox(height: 20.h),
              CustomTextButton(
                text: 'Log In',
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
