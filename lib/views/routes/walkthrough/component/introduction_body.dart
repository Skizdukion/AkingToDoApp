import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/logic/models/walkthrough.dart';
import 'package:todo_app/views/routes/walkthrough/component/intro_button.dart';
import 'package:todo_app/views/routes/walkthrough/component/intro_content.dart';

class IntroductionBody extends StatefulWidget {
  const IntroductionBody({Key? key, required this.walkThroughData}) : super(key: key);
  final List<Walkthrough> walkThroughData;

  @override
  _IntroductionBodyState createState() => _IntroductionBodyState();
}

class _IntroductionBodyState extends State<IntroductionBody> {

  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child){
        return Column(
          children: [
            Spacer(),
            SizedBox(
              height: 500.h,
              child: PageView.builder(     
                controller: _pageController,
                onPageChanged: (value) => changePage(value),       
                itemCount: widget.walkThroughData.length,
                itemBuilder: (context, index) => WalkthroughContent(
                  description: widget.walkThroughData[_currentPage].description,
                  image: widget.walkThroughData[_currentPage].imageTopPath,
                  title: widget.walkThroughData[_currentPage].title,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.walkThroughData.length,(index) => buildDot(index: index))
            ),
            Spacer(),
            Container(
              width: 1.sw,
              height: 275.h,
              child: IntroButton(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.walkThroughData[_currentPage].imageBottomPath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  void changePage(value){
    setState(() {
      _currentPage = value;
    });
  }
  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 5),
        height: 6,
        width: index == _currentPage ? 20 : 6,
        decoration: BoxDecoration(
          color: index == _currentPage ? widget.walkThroughData[_currentPage].waveColor: const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3.r),
        ));
  }
}