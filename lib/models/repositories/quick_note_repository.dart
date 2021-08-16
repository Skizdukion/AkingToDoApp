import 'package:todo_app/models/providers/local_data.dart';
import 'package:todo_app/models/repositories/models/quick_note.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


abstract class QuickNoteRepository{
  List<QuickNoteModel> getQuickNoteList();
  void deleteQuickNote(String id);
  void addQuickNote(QuickNoteModel item);
  const QuickNoteRepository();
}

class FakeQuickNoteRepository extends QuickNoteRepository{
  const FakeQuickNoteRepository();
  static var localData = LocalDataProvider();

  @override
  void addQuickNote(QuickNoteModel item) {
    localData.quickNoteList.add(item);
  }

  @override
  void deleteQuickNote(String id) {
    localData.quickNoteList.remove(getQuickNote(id));
  }

  void changeDoneState(String quickNoteId, String listItemId){
    QuickNoteModel? quickNote = getQuickNote(quickNoteId);
    QuickNoteCheckListItemModel? item;
    quickNote!.itemList.forEach((val) {
      if(val.id == listItemId){
        item = val;
      }
    });
    item!.isDone = !item!.isDone;
  }

  @override
  List<QuickNoteModel> getQuickNoteList() {
    return localData.quickNoteList;
  }

  QuickNoteModel? getQuickNote(String projectId){
    QuickNoteModel? result;
    localData.quickNoteList.forEach((val) {
      if(val.id == projectId){
        result = val;
      }
    });
    return result;
  }


}