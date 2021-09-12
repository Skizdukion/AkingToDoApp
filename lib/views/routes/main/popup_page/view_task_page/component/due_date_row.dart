import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';

import 'component_template.dart';

class DueDateRow extends StatelessWidget {
  const DueDateRow({Key? key, required this.dueDate, required this.isEvent})
      : super(key: key);
  final DateTime? dueDate;
  final bool isEvent;

  @override
  Widget build(BuildContext context) {
    return ComponentTemplate(child: [
      SizedBox(width: 10),
      Icon(
        Icons.calendar_today_outlined,
        size: 15,
      ),
      SizedBox(
        width: 25,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Due Date",
            style: AppTextDecoration.light154W400S14
                .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            (isEvent == false)
                ? 'Anytime'
                : DateFormat('MMM d/yyyy').format(dueDate!),
            style: AppTextDecoration.darkS18.copyWith(fontSize: 16),
          ),
        ],
      ),
    ]);
  }
}
