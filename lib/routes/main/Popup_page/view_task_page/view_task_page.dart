import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/repositories/models/task.dart';
import 'package:todo_app/models/repositories/models/user.dart';
import 'package:todo_app/models/repositories/user_repository.dart';
import 'package:todo_app/widgets/const_decoration.dart';

import 'component/asignee_row.dart';
import 'component/desc_row.dart';
import 'component/due_date_row.dart';
import 'component/member_list_row.dart';
import 'component/tag_row.dart';

class TaskViewPage extends StatefulWidget {
  const TaskViewPage({Key? key, required this.item}) : super(key: key);
  final TaskModel item;

  @override
  _TaskViewPageState createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> {
  FakeUserRepository _userRepository = FakeUserRepository();
  late UserModel userTaskOwner;

  @override
  void initState() {
    userTaskOwner = _userRepository.getUserWithId(widget.item.userId)!;
    print(widget.item.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                icon: Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
              Spacer(),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    child: Text('Add to Project'),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text('Add Member'),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text('Delete Task'),
                    value: 2,
                  ),
                ],
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                iconSize: 30,
                onSelected: (int value) {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                offset: Offset(-10, 40),
              )
            ],
          ),
          Flexible(
            child: Text(
              widget.item.title,
              style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          AsigneeRow(
            urlImg: userTaskOwner.imgUrl,
            userName: userTaskOwner.name,
          ),
          SizedBox(
            height: 20,
          ),
          DueDateRow(
            dueDate: widget.item.dueDate,
          ),
          SizedBox(
            height: 20,
          ),
          DescRow(
            description: widget.item.description,
          ),
          SizedBox(
            height: 20,
          ),
          MemberListRow(
            memberList: widget.item.memberList,
          ),
          SizedBox(
            height: 20,
          ),
          TagRow(
            projectList: widget.item.projectList,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                style: buttonStyleAuthPages.copyWith(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      !widget.item.isDone ? Color.fromRGBO(96, 116, 249, 1) : Color.fromRGBO(249, 96, 96, 1)),
                ),
                child: Text(
                  !widget.item.isDone ? 'Complete Task' : 'Uncomplete Task',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
