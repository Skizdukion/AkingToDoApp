import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalkthroughContent extends StatelessWidget {
  const WalkthroughContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title, description, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 392.h,
          child: Image.asset(
            image,
            width: 300.w,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(49, 49, 49, 1),
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 9.h),
        Text(
          description,
          style: TextStyle(fontSize: 18.0, color: Color.fromRGBO(49, 49, 49, 1)),
        ),
      ],
    );
  }
}
