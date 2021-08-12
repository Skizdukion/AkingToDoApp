import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/models/user.dart';
import 'package:todo_app/routes/main/Popup_page/new_task/suggest_card.dart';
import 'package:todo_app/routes/main/popup_page/new_task/selected_suggest_card.dart';
import 'package:todo_app/widgets/const_decoration.dart';
class ForInRow extends StatefulWidget {
  const ForInRow({ 
    Key? key,
    required this.asigneeFieldOnChange, 
    required this.asigneeFieldOntap, 
    required this.projectFieldOnChange, 
    required this.projectFieldOntap,
    required this.userSelect,
    required this.projectSelect,
    required this.asigneeFieldReset,
    required this.projectFieldReset,
  }) : super(key: key);
  final VoidCallback asigneeFieldOntap;
  final VoidCallback projectFieldOntap;
  final VoidCallback asigneeFieldReset;
  final VoidCallback projectFieldReset;
  final ValueSetter<String> asigneeFieldOnChange;
  final ValueSetter<String> projectFieldOnChange;
  final UserModel? userSelect;
  final ProjectModel? projectSelect;

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
        if (widget.userSelect == null) SelectSuggestCard(initText: 'Asignee', key: Key('Asignee'), onTap: widget.asigneeFieldOntap, onChange: widget.asigneeFieldOnChange,),
        if (widget.userSelect != null) UserSelectedSuggestCard(onTap: widget.asigneeFieldReset, item: widget.userSelect!),
        Spacer(),
        Text('In', style: textDarkStyleS18,),
        SizedBox(width: 8,),
        if (widget.projectSelect == null) SelectSuggestCard(initText: 'Project', key: Key('Project'), onTap: widget.projectFieldOntap, onChange: widget.projectFieldOnChange,),
        if (widget.projectSelect != null) ProjectSelectedSuggestCard(onTap: widget.projectFieldReset, item: widget.projectSelect!),
      ],
    );
  }
}