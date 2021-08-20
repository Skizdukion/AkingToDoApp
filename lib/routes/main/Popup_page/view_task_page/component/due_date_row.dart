import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/routes/main/popup_page/view_task_page/component/component_template.dart';
import 'package:todo_app/widgets/const_decoration.dart';



class DueDateRow extends StatelessWidget {
  const DueDateRow({ Key? key, required this.dueDate }) : super(key: key);
  final DateTime? dueDate;

  @override
  Widget build(BuildContext context) {
    return ComponentTemplate(child: [
      SizedBox(width: 10),
      Icon(
        Icons.calendar_today_outlined,
        size: 15,
      ),
      SizedBox(width: 25,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Due Date", style: textLight154StyleW400S14.copyWith(fontWeight: FontWeight.bold, fontSize: 16),),
          SizedBox(height: 5,),
          Text((dueDate == null) ? 'Anytime' : DateFormat('MMM d/yyyy').format(dueDate!), style: textDarkStyleS18.copyWith(fontSize: 16),),
        ],
      ),
    ]);
  }
}