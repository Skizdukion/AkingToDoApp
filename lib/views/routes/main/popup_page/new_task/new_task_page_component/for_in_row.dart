import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_state.dart';
import 'package:todo_app/views/routes/main/popup_page/new_task/new_task_page_component/project_field.dart';

import 'asignee_field.dart';

class ForInRow extends StatefulWidget {
  const ForInRow({
    Key? key,
  }) : super(key: key);

  @override
  _ForInRowState createState() => _ForInRowState();
}

class _ForInRowState extends State<ForInRow> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskBloc, NewTaskState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'For',
              style: AppTextDecoration.darkS18,
            ),
            SizedBox(
              width: 8,
            ),
            AsigneeField(),
            Spacer(),
            Text(
              'In',
              style: AppTextDecoration.darkS18,
            ),
            SizedBox(
              width: 8,
            ),
            ProjectField(),
            SizedBox(
              width: 10,
            ),
          ],
        );
      },
    );
  }
}
