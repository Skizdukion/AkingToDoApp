import 'package:flutter/cupertino.dart';

class CheckNote{
  bool isDone;
  String title;
  CheckNote({required this.isDone, required this.title});
}

class CheckListModel with ChangeNotifier{
  List<CheckNote> checkList;
  CheckListModel({required this.checkList});
  CheckListModel.fakeData():checkList = [
    CheckNote(isDone: false, title: 'Item 1'),
  ];

  void addAutoCheckNote(){
    if(checkList.length < 6){
      checkList.add(CheckNote(title: 'Item ${checkList.length + 1}', isDone: false));
      notifyListeners();
    }
  }

  void setTrueFalse(index, bool? value){
    checkList[index].isDone = value!;
    notifyListeners();
  }
}
