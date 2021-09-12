import 'package:flutter/material.dart';
import 'package:todo_app/views/routes/introduction/component/introduction_top_screen.dart';

import 'component/intro_button.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            Expanded(flex: 70, child: IntroductionTopScreen()),
            Expanded(
                flex: 30,
                child: Container(
                  child: IntroButton(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/intro_below.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
