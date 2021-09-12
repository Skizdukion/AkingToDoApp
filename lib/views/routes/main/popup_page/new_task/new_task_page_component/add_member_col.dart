import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_event.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_state.dart';
import 'package:todo_app/logic/models/user.dart';
import 'package:todo_app/views/widgets/image_loading.dart';
import 'package:todo_app/views/widgets/member_list_picker.dart';

class AddMemberCol extends StatefulWidget {
  const AddMemberCol({Key? key}) : super(key: key);

  @override
  _AddMemberColState createState() => _AddMemberColState();
}

class _AddMemberColState extends State<AddMemberCol> {
  List<String> memberStringList = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskBloc, NewTaskState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.only(left: 24),
        child: Column(
          children: [
            Text(
              'Add Member',
              style: AppTextDecoration.darkW400S16,
            ),
            SizedBox(height: 8),
            if (state.memberList.length == 0)
              SizedBox(
                height: 50,
                width: 90,
                child: TextButton(
                  child: Text(
                    'Anyone',
                    style: AppTextDecoration.darkW400S16.copyWith(fontSize: 14),
                  ),
                  onPressed: () {
                    _showAddMenu();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(244, 244, 244, 1)),
                  ),
                ),
              ),
            if (state.memberList.length != 0)
              Row(
                children: [
                  for (var item in state.memberList)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ImgLoading(imgUrl: item.imgUrl, radius: 16),
                    ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(204, 204, 204, 1),
                    ),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        _showAddMenu();
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 16,
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      );
    });
  }

  _showAddMenu() async {
    List<UserModel>? returnList = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: MemberListPicker(
                    memberList: memberStringList,
                  ),
                ),
                insetPadding: EdgeInsets.symmetric(horizontal: 20),
              ));
        });
    if (returnList != null) {
      memberStringList.clear();
      context
          .read<NewTaskBloc>()
          .add(MemberListOnChange(memberList: returnList));
      for (var item in returnList) {
        memberStringList.add(item.id);
      }
    }
  }
}
