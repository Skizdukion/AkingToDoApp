import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComponentTemplate extends StatelessWidget {
  const ComponentTemplate({Key? key, required this.child}) : super(key: key);
  final List<Widget> child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            Row(
              children: [
                for (var item in child) item,
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Divider(),
          ],
        ));
  }
}
