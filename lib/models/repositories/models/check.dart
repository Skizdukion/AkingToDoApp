import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/repositories/models/quick_note.dart';

class CheckNote{
  bool isDone;
  String title;
  CheckNote({required this.isDone, required this.title});
}

class CheckListModel with ChangeNotifier{
  List<QuickNoteCheckListItemModel> checkList;
  CheckListModel({required this.checkList});
  CheckListModel.fakeData():checkList = [
    QuickNoteCheckListItemModel(isDone: false, desc: 'Item 1', id: '1'),
  ];

  void addAutoCheckNote(){
    checkList.add(QuickNoteCheckListItemModel(isDone: false, desc: 'Item ${checkList.length + 1}', id: '${checkList.length + 1}'));
    notifyListeners();
  }

  void setTrueFalse(index, bool? value){
    checkList[index].isDone = value!;
    notifyListeners();
  }
}