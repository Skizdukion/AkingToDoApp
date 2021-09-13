import 'package:flutter/material.dart';
import 'package:todo_app/logic/models/walkthrough.dart';
import 'package:todo_app/views/routes/walkthrough/component/introduction_body.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IntroductionBody(
        walkThroughData: [
          Walkthrough("Welcome to aking", "What's going to happen tomorrow?", 'assets/intro_image_1.png', Color(0xFFF96060), 'assets/intro_below_1.png'),
          Walkthrough("Work happens", "Get notified when work happens.", "assets/intro_image_2.png", Color(0xFF6074F9), 'assets/intro_below_2.png'),
          Walkthrough('Task and assign', 'Task and assign them to colleagues.', 'assets/intro_image_3.png', Color(0xFF8560F9), 'assets/intro_below_3.png'),
        ]),
    );
  }
}