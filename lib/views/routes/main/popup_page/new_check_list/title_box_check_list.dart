import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TilteBoxCheckList extends StatefulWidget {
  const TilteBoxCheckList({Key? key, required this.titleController})
      : super(key: key);
  final TextEditingController titleController;
  @override
  _TilteBoxCheckListState createState() => _TilteBoxCheckListState();
}

class _TilteBoxCheckListState extends State<TilteBoxCheckList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Title',
            style: AppTextDecoration.darkS18,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 310.w,
            height: 40.h,
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
                      textInputAction: TextInputAction.done,
                      controller: widget.titleController,
                      style: AppTextDecoration.darkS18,
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
