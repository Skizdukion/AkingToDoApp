import 'package:flutter/material.dart';

class RadioColor {
  bool isSelected;
  final Color color;
  RadioColor({required this.isSelected, required this.color});
}

class RadioColorList with ChangeNotifier {
  List<RadioColor> colorList;
  int colorPick = 0;
  RadioColorList({required this.colorList});
  RadioColorList.autoInitial()
      : colorList = [
          RadioColor(color: Color.fromRGBO(96, 116, 249, 1), isSelected: true),
          RadioColor(color: Color.fromRGBO(228, 43, 106, 1), isSelected: false),
          RadioColor(color: Color.fromRGBO(90, 187, 86, 1), isSelected: false),
          RadioColor(color: Color.fromRGBO(61, 58, 98, 1), isSelected: false),
          RadioColor(
              color: Color.fromRGBO(244, 202, 143, 1), isSelected: false),
        ];

  void pickColor(index) {
    colorList.forEach((element) => element.isSelected = false);
    colorList[index].isSelected = true;
    colorPick = index;
    notifyListeners();
  }

  Color getSelectColor() {
    return colorList[colorPick].color;
  }
}
