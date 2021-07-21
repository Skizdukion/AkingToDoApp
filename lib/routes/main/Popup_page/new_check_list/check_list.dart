import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/check.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class CheckList extends StatefulWidget {
  const CheckList({ Key? key, required this.checkList }) : super(key: key);

  final List<CheckNote> checkList;

  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Column(
        children: [
           ListView.builder(
            shrinkWrap: true,
            itemCount: widget.checkList.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckNoteItem(checkNote: widget.checkList[index],);
            },
          ),
        ],
      ),
    );
  }
}


class CheckNoteItem extends StatefulWidget {
  CheckNoteItem({ Key? key, required this.checkNote }) : super(key: key);
  final CheckNote checkNote;

  @override
  _CheckNoteItemState createState() => _CheckNoteItemState();
}

class _CheckNoteItemState extends State<CheckNoteItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
          Expanded(
            child: Center(
              child: TextFormField(
                textInputAction: TextInputAction.done,
                style: textDarkStyleW400S16,
                initialValue: widget.checkNote.title,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}