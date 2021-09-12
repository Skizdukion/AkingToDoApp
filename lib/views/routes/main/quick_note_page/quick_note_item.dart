import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/models/quick_note.dart';
import 'package:todo_app/logic/repositories/quick_note_repository.dart';

class QuickNoteItem extends StatefulWidget {
  const QuickNoteItem({Key? key, required this.item}) : super(key: key);
  final QuickNoteModel item;

  @override
  _QuickNoteItemState createState() => _QuickNoteItemState();
}

class _QuickNoteItemState extends State<QuickNoteItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        showAllActionsThreshold: 0.1,
        actionExtentRatio: 0.25,
        actions: <Widget>[
          IconSlideAction(
            color: Colors.white10,
            iconWidget: Icon(Icons.delete_outline,
                color: Color.fromRGBO(249, 96, 96, 1)),
            onTap: () => deleteQuickNote(),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            color: Colors.white10,
            iconWidget: Icon(Icons.delete_outline,
                color: Color.fromRGBO(249, 96, 96, 1)),
            onTap: () => deleteQuickNote(),
          ),
        ],
        child: Material(
          elevation: 2.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 200, bottom: 10),
                  child: Divider(
                    color: widget.item.color,
                    thickness: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    '${widget.item.title}',
                    style: AppTextDecoration.darkS18
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                for (var item in widget.item.checkList)
                  QuickNoteCheckListItem(
                    item: item,
                    parentId: widget.item.id,
                  ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteQuickNote() async {
    var result = await showOkCancelAlertDialog(
        context: context, title: 'Are you wish to delete this?');
    if (result == OkCancelResult.ok) {
      FirebaseQuickNoteRepository().deleteTask(widget.item.id);
    }
  }
}

class QuickNoteCheckListItem extends StatefulWidget {
  const QuickNoteCheckListItem(
      {Key? key, required this.item, required this.parentId})
      : super(key: key);
  final QuickNoteCheckListItemModel item;
  final String parentId;

  @override
  _QuickNoteCheckListItemState createState() => _QuickNoteCheckListItemState();
}

class _QuickNoteCheckListItemState extends State<QuickNoteCheckListItem> {
  FirebaseQuickNoteRepository _quickNoteRepository =
      FirebaseQuickNoteRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              value: widget.item.isDone,
              onChanged: (bool? val) {
                _quickNoteRepository.changeDoneState(
                    widget.parentId, widget.item.id);
              },
            ),
            Flexible(
                child: Text(
              '${widget.item.listTitle}',
              style: widget.item.isDone
                  ? AppTextDecoration.lineThrough.copyWith(
                      color: Color.fromRGBO(49, 49, 49, 1),
                    )
                  : AppTextDecoration.darkW400S16,
            )),
          ],
        ),
      ),
    );
  }
}
