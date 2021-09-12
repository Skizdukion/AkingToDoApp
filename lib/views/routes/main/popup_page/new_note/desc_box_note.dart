import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionNotePanel extends StatefulWidget {
  const DescriptionNotePanel({Key? key, required this.textController})
      : super(key: key);
  final TextEditingController textController;

  @override
  _DescriptionNotePanelState createState() => _DescriptionNotePanelState();
}

class _DescriptionNotePanelState extends State<DescriptionNotePanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Description',
            style: AppTextDecoration.darkS18,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 310.w,
            height: 150.h,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: TextFormField(
                      controller: widget.textController,
                      style: AppTextDecoration.darkS18,
                      minLines: 6,
                      maxLines: 6,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
