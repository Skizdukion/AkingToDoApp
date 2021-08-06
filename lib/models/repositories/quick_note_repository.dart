import 'package:todo_app/models/repositories/models/quick_note.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


List<QuickNoteModel> fakeDataQuickNote = [
  QuickNoteModel(id: '1', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Meeting with Jessica in Central Park at 10:30PM', itemList: [
    QuickNoteCheckListItemModel(desc: 'Math fasfjqw hgafhq gahfhq gashfgqh ghashf', id: '0'),
    QuickNoteCheckListItemModel(desc: 'Chemistry', id: '1'),
    QuickNoteCheckListItemModel(desc: 'Literature', id: '2'),
    QuickNoteCheckListItemModel(desc: 'Physic', id: '3'),
  ]),
  QuickNoteModel(id: '2', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Clean house', itemList: [
    QuickNoteCheckListItemModel(desc: 'Kitchen', id: '1'),
    QuickNoteCheckListItemModel(desc: 'Bath room', id: '2'),
    QuickNoteCheckListItemModel(desc: 'Bed room', id: '3'),
  ]),
  QuickNoteModel(id: '3', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Make dinner', itemList: [
    QuickNoteCheckListItemModel(desc: 'Buy fish', id: '1'),
    QuickNoteCheckListItemModel(desc: 'Make sweetdish meatball', id: '2'),
  ]),
  QuickNoteModel(id: '4', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Random stuff', itemList: [
    QuickNoteCheckListItemModel(desc: 'Random stuff 1', id: '1'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 2', id: '2'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 3', id: '3'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 4', id: '4'),
  ]),
  QuickNoteModel(id: '5', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Random stuff 1', itemList: [
    QuickNoteCheckListItemModel(desc: 'Random stuff 1', id: '1'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 2', id: '2'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 3', id: '3'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 4', id: '4'),
  ]),
  QuickNoteModel(id: '6', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Random stuff 2', itemList: [
    QuickNoteCheckListItemModel(desc: 'Random stuff 1', id: '1'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 2', id: '2'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 3', id: '3'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 4', id: '4'),
  ]),
  QuickNoteModel(id: '7', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Random stuff 3', itemList: [
    QuickNoteCheckListItemModel(desc: 'Random stuff 1', id: '1'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 2', id: '2'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 3', id: '3'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 4', id: '4'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 5', id: '5'),
    QuickNoteCheckListItemModel(desc: 'Random stuff 6', id: '6'),
  ]),
];

abstract class QuickNoteRepository{
  List<QuickNoteModel> getQuickNoteList();
  void deleteQuickNote(String id);
  void addQuickNote(QuickNoteModel item);
  const QuickNoteRepository();
}

class FakeQuickNoteRepository extends QuickNoteRepository{
  const FakeQuickNoteRepository();

  static var quickNoteList = fakeDataQuickNote;

  @override
  void addQuickNote(QuickNoteModel item) {
    quickNoteList.add(item);
  }

  @override
  void deleteQuickNote(String id) {
    quickNoteList.remove(getQuickNote(id));
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
    return quickNoteList;
  }

  QuickNoteModel? getQuickNote(String projectId){
    QuickNoteModel? result;
    quickNoteList.forEach((val) {
      if(val.id == projectId){
        result = val;
      }
    });
    return result;
  }


}