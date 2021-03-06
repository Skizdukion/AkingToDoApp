import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/logic/models/quick_note.dart';
import 'package:todo_app/logic/providers/firebase_data.dart';
import 'package:uuid/uuid.dart';

abstract class QuickNoteRepository {
  List<QuickNoteModel> getQuickNoteList();
  void deleteQuickNote(String id);
  void addQuickNote(QuickNoteModel item);
  const QuickNoteRepository();
}

class FirebaseQuickNoteRepository {
  FirebaseQuickNoteRepository() {
    userQuickNoteRef = FirebaseFirestore.instance
        .collection('quick_note')
        .where('userId', isEqualTo: FirebaseDataProvider.uid);
  }

  late Query userQuickNoteRef;

  Stream<QuerySnapshot> requestTotalQuickNoteCount() {
    return userQuickNoteRef.snapshots();
  }

  Stream<List<QuickNoteModel>> getStreamQuickNoteList() {
    return userQuickNoteRef
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map(_quickNoteListDataFromSnapShot);
  }

  List<QuickNoteModel> _quickNoteListDataFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return _quickNoteDataFromSnapShot(doc);
    }).toList();
  }

  QuickNoteModel _quickNoteDataFromSnapShot(DocumentSnapshot snapshot) {
    return QuickNoteModel(
      id: snapshot.reference.id,
      title: snapshot['title'],
      color: _convertMapToColor(snapshot),
      userId: snapshot['userId'],
      checkList: _checkListInQuickNoteFromSnapShot(snapshot),
    );
  }

  List<QuickNoteCheckListItemModel> _checkListInQuickNoteFromSnapShot(
      DocumentSnapshot snapshot) {
    List<QuickNoteCheckListItemModel> checkList = [];
    List listFromSnapShot = snapshot['checkList'];
    for (var item in listFromSnapShot) {
      checkList.add(QuickNoteCheckListItemModel(
        listTitle: item['listTitle'],
        id: item['id'],
        isDone: item['isDone'],
      ));
    }
    return checkList;
  }

  Map convertCheckItemToMap(QuickNoteCheckListItemModel item) {
    Map<String, dynamic> checkItem = {
      'id': item.id,
      'listTitle': item.listTitle,
      'isDone': item.isDone,
    };
    return checkItem;
  }

  List convertCheckListToFirebaseStorableList(
      List<QuickNoteCheckListItemModel> checkList) {
    List returnList = [];
    for (var item in checkList) {
      returnList.add(convertCheckItemToMap(item));
    }
    return returnList;
  }

  void addQuickNote(QuickNoteModel quickNote) {
    var uuid = Uuid();
    String randomId = uuid.v4();
    FirebaseFirestore.instance.collection('quick_note').doc(randomId).set({
      'color': convertColorToMap(quickNote.color),
      'createdDate': Timestamp.fromDate(DateTime.now()),
      'title': quickNote.title,
      'userId': FirebaseDataProvider.uid,
      'checkList': convertCheckListToFirebaseStorableList(quickNote.checkList),
    });
  }

  void changeDoneState(String quickNoteId, String itemId) {
    FirebaseFirestore.instance
        .collection('quick_note')
        .doc(quickNoteId)
        .get()
        .then((doc) => updateDoneStateInQuickNote(doc, itemId));
  }

  void updateDoneStateInQuickNote(DocumentSnapshot doc, String itemId) {
    QuickNoteModel _quickNote = _quickNoteDataFromSnapShot(doc);
    for (var item in _quickNote.checkList) {
      if (item.id == itemId) {
        item.isDone = !item.isDone;
      }
    }
    updateQuickNoteDocument(_quickNote);
  }

  void updateQuickNoteDocument(QuickNoteModel quickNote) {
    FirebaseFirestore.instance
        .collection('quick_note')
        .doc(quickNote.id)
        .update({
      'checkList': convertCheckListToFirebaseStorableList(quickNote.checkList),
      'color': convertColorToMap(quickNote.color),
      'title': quickNote.title,
    });
  }

  Color _convertMapToColor(DocumentSnapshot snapshot) {
    Map<String, dynamic> rgbColor = snapshot['color'];
    return Color.fromRGBO(rgbColor['red'], rgbColor['green'], rgbColor['blue'],
        (rgbColor['opacity'] as num).toDouble());
  }

  Map convertColorToMap(Color color) {
    Map<String, num> mapColor = {
      'red': color.red,
      'blue': color.blue,
      'green': color.green,
      'opacity': color.opacity,
    };
    return mapColor;
  }

  void deleteTask(String id) {
    FirebaseFirestore.instance.collection('quick_note').doc(id).delete();
  }
}
