import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/views/widgets/image_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'component_template.dart';

class AsigneeRow extends StatelessWidget {
  const AsigneeRow({Key? key, required this.urlImg, required this.userName})
      : super(key: key);
  final String urlImg;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return ComponentTemplate(
      child: [
        ImgLoading(imgUrl: urlImg, radius: 20),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Assigned to",
                style: AppTextDecoration.light154W400S14
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(
              height: 5.h,
            ),
            Text(
              userName,
              style: AppTextDecoration.darkS18.copyWith(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
