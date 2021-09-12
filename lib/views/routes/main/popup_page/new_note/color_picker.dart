import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/models/radio_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Choose Color',
            style: AppTextDecoration.darkS18,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 48.h,
            child: Consumer<RadioColorList>(builder: (_, value, __) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: value.colorList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new InkWell(
                    onTap: () {
                      value.pickColor(index);
                    },
                    child: ColorBtn(item: value.colorList[index]),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ColorBtn extends StatefulWidget {
  const ColorBtn({Key? key, required this.item}) : super(key: key);
  final RadioColor item;

  @override
  _ColorBtnState createState() => _ColorBtnState();
}

class _ColorBtnState extends State<ColorBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.item.color,
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: widget.item.isSelected
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : null,
        ),
        width: 48.w,
      ),
    );
  }
}
