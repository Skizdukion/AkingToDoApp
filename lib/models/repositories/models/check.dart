import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/repositories/models/quick_note.dart';
import 'package:uuid/uuid.dart';

class CheckNote{
  bool isDone;
  String title;
  CheckNote({required this.isDone, required this.title});
}

class CheckListModel with ChangeNotifier{
  List<QuickNoteCheckListItemModel> checkList;
  CheckListModel({required this.checkList});
  CheckListModel.fakeData():checkList = [
    QuickNoteCheckListItemModel(isDone: false, listTitle: 'Item 1', id: '1'),
  ];

  void addAutoCheckNote(){
    var uuid = Uuid();
    String randomId = uuid.v4();
    checkList.add(QuickNoteCheckListItemModel(isDone: false, listTitle: 'Item ${checkList.length + 1}', id: randomId));
    notifyListeners();
  }

  void setTrueFalse(index, bool? value){
    checkList[index].isDone = value!;
    notifyListeners();
  }

  void changeTitle(index, String title){
    checkList[index].listTitle = title;
    notifyListeners();
  }
}