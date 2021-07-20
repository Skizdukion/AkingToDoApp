import 'package:flutter/material.dart';
import 'package:todo_app/routes/main/Popup_page/new_task/suggest_card.dart';
import 'package:todo_app/widgets/const_decoration.dart';
class ForInRow extends StatefulWidget {
  const ForInRow({ Key? key }) : super(key: key);

  @override
  _ForInRowState createState() => _ForInRowState();
}

class _ForInRowState extends State<ForInRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20,),
        Text('For', style: textDarkStyleS18,),
        SizedBox(width: 8,),
        SelectSuggestCard(initText: 'Asignee', key: Key('Asignee'),),
        SizedBox(width: 60,),
        Text('In', style: textDarkStyleS18,),
        SizedBox(width: 8,),
        SelectSuggestCard(initText: 'Project', key: Key('Project')),
      ],
    );
  }
}