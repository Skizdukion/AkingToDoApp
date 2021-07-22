import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/repositories/models/check.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class CheckList extends StatefulWidget {
  const CheckList({ Key? key,}) : super(key: key);

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
            itemCount: getListLength(),
            itemBuilder: (BuildContext context, int index) {
              return CheckNoteItem(index: index);
            },
          ),
        ],
      ),
    );
  }

  int getListLength(){
    var value = Provider.of<CheckListModel>(context, listen: false);
    return value.checkList.length;
  }
}


class CheckNoteItem extends StatefulWidget {
  CheckNoteItem({ Key? key, required this.index }) : super(key: key);
  final int index;

  @override
  _CheckNoteItemState createState() => _CheckNoteItemState();
}

class _CheckNoteItemState extends State<CheckNoteItem> {

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckListModel>(
      builder: (_, value, __){
        return Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: value.checkList[widget.index].isDone,
                onChanged: (bool? val) {  
                  value.setTrueFalse(widget.index, val);
                },
              ),
              Expanded(
                child: Center(
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    style: textDarkStyleW400S16,
                    initialValue: value.checkList[widget.index].title,
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
    );
  }
}