import 'package:flutter/material.dart';
import 'package:todo_app/routes/introduction/intro_button.dart';
import 'package:todo_app/routes/introduction/introduction_page.dart';
import 'package:todo_app/routes/main/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aking',
      home: SafeArea(
        child: MainPage(),
      ),
    );
  }

  Widget initialScreen(){
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(flex: 70,child: IntroductionPage()),
            Expanded(flex: 30,child: Container(
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
}


