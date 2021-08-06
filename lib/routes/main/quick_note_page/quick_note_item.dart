import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/quick_note.dart';
import 'package:todo_app/models/repositories/quick_note_repository.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class QuickNoteItem extends StatefulWidget {
  const QuickNoteItem({ Key? key, required this.item }) : super(key: key);
  final QuickNoteModel item;

  @override
  _QuickNoteItemState createState() => _QuickNoteItemState();
}

class _QuickNoteItemState extends State<QuickNoteItem> {

  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          isExpand = !isExpand;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 200, bottom: 10),
                  child: Divider(
                    color: widget.item.color,
                    thickness: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text('${widget.item.title}', style: textDarkStyleS18.copyWith(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                if (isExpand == true) const SizedBox(height: 16,),
                if (isExpand == true) for (var item in widget.item.itemList) QuickNoteCheckListItem(item: item, parentId: widget.item.id,),
                const SizedBox(height: 16,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuickNoteCheckListItem extends StatefulWidget {
  const QuickNoteCheckListItem({ Key? key, required this.item, required this.parentId }) : super(key: key);
  final QuickNoteCheckListItemModel item;
  final String parentId;

  @override
  _QuickNoteCheckListItemState createState() => _QuickNoteCheckListItemState();
}

class _QuickNoteCheckListItemState extends State<QuickNoteCheckListItem> {

  late bool isDone;
  FakeQuickNoteRepository _quickNoteRepository = FakeQuickNoteRepository();

  @override
  void initState() {
    isDone = widget.item.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              checkColor: Colors.white,
              value: isDone,
              onChanged: (bool? val) {  
                setState(() {
                  isDone = val!;
                });
                _quickNoteRepository.changeDoneState(widget.parentId, widget.item.id);
              },
            ),
            Flexible(child: Text('${widget.item.desc}', style: isDone ? textLineThroughStyle : textDarkStyleW400S16,)),
          ],
        ),
      ),
    );
  }
}