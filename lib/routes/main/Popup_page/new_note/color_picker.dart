import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/repositories/models/radio_color.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({ Key? key }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Choose Color',style: textDarkStyleS18,),
            SizedBox(height: 10,),
            Container(
              height: 48,
              child: Consumer<RadioColorList>(
                builder: (_, value, __){
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: value.colorList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new InkWell(
                        onTap: (){
                          value.pickColor(index);
                        },
                        child: ColorBtn(color: value.colorList[index]),
                      );
                    },
                  );
                }
              ),
            ),
          ],
        ),
    );
  }
}

class ColorBtn extends StatefulWidget {
  const ColorBtn({ Key? key, required this.color }) : super(key: key);
  final RadioColor color;

  @override
  _ColorBtnState createState() => _ColorBtnState();
}

class _ColorBtnState extends State<ColorBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.color.color,
          border: (widget.color.isSelected ? Border.all(color: Colors.black) : Border.all(color: Colors.white))
        ),
        width: 48,
      ),
    );
  }
}

