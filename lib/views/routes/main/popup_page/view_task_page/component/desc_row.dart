import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'component_template.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescRow extends StatelessWidget {
  const DescRow({Key? key, required this.description}) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return ComponentTemplate(child: [
      SizedBox(width: 10.w),
      Icon(
        Icons.description,
        size: 15,
      ),
      SizedBox(
        width: 25.w,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: AppTextDecoration.light154W400S14
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    description,
                    style: AppTextDecoration.darkS18.copyWith(fontSize: 16),
                  ),
                  fit: FlexFit.loose,
                ),
                if (description == '')
                  SizedBox(
                    height: 20.h,
                  ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
