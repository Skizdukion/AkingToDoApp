import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/radio_color.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({ Key? key }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {

  List<RadioColor> colorList = [];

  @override
  void initState() {
    colorList.add(RadioColor(color: Color.fromRGBO(96, 116, 249, 1), isSelected: true));
    colorList.add(RadioColor(color:Color.fromRGBO(228, 43, 106, 1), isSelected: false));
    colorList.add(RadioColor(color:Color.fromRGBO(90, 187, 86, 1), isSelected: false));
    colorList.add(RadioColor(color:Color.fromRGBO(61, 58, 98, 1), isSelected: false));
    colorList.add(RadioColor(color:Color.fromRGBO(244, 202, 143, 1), isSelected: false));
    super.initState();
  }

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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: colorList.length,
              itemBuilder: (BuildContext context, int index) {
                return new InkWell(
                  onTap: (){
                    setState(() {
                      colorList.forEach((element) => element.isSelected = false);
                      colorList[index].isSelected = true;
                    });
                  },
                  child: ColorBtn(color: colorList[index]),
                );
              },
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

