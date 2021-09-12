import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroductionTopScreen extends StatefulWidget {
  const IntroductionTopScreen({Key? key}) : super(key: key);

  @override
  _IntroductionTopScreenState createState() => _IntroductionTopScreenState();
}

class _IntroductionTopScreenState extends State<IntroductionTopScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.h),
      child: IntroductionScreen(
        pages: listIntroPage,
        showDoneButton: false,
        showNextButton: false,
        showSkipButton: false,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

var listIntroPage = [
  PageViewModel(
      title: "Welcome to aking",
      body: "What's going to happen tomorrow?",
      image: const Center(
          child: Image(image: AssetImage('assets/intro_image_1.png'))),
      decoration: pageDecoration),
  PageViewModel(
      title: "Work happens",
      body: "Get notified when work happens.",
      image: const Center(
          child: Image(image: AssetImage('assets/intro_image_2.png'))),
      decoration: pageDecoration),
  PageViewModel(
    title: "Task and assign",
    body: "Task and assign them to colleagues.",
    image: const Center(
        child: Image(image: AssetImage('assets/intro_image_3.png'))),
    decoration: pageDecoration,
  ),
];

var pageDecoration = PageDecoration(
  titleTextStyle: TextStyle(
    color: Color.fromRGBO(49, 49, 49, 1),
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  ),
  bodyTextStyle:
      TextStyle(fontSize: 18.0, color: Color.fromRGBO(49, 49, 49, 1)),
  titlePadding: EdgeInsets.only(top: 50.h, bottom: 20.h),
  imagePadding: EdgeInsets.only(top: 0),
);
