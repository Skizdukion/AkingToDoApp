import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_event.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_state.dart';
import 'package:todo_app/logic/models/user.dart';
import 'package:todo_app/views/widgets/image_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AsigneeSuggestPanel extends StatefulWidget {
  const AsigneeSuggestPanel({Key? key}) : super(key: key);

  @override
  _AsigneeSuggestPanelState createState() => _AsigneeSuggestPanelState();
}

class _AsigneeSuggestPanelState extends State<AsigneeSuggestPanel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskBloc, NewTaskState>(builder: (context, state) {
      return Flexible(
          child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 244, 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListView.builder(
          itemCount: state.userList.length,
          itemBuilder: (context, index) {
            return AsigneeUserSuggestion(
              item: state.userList[index],
            );
          },
        ),
      ));
    });
  }
}

class AsigneeUserSuggestion extends StatefulWidget {
  const AsigneeUserSuggestion({Key? key, required this.item}) : super(key: key);
  final UserModel item;

  @override
  _AsigneeUserSuggestionState createState() => _AsigneeUserSuggestionState();
}

class _AsigneeUserSuggestionState extends State<AsigneeUserSuggestion> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskBloc, NewTaskState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.only(top: 16.h, left: 16.w, bottom: 10.h),
        child: InkWell(
          child: Container(
            child: Row(
              children: [
                ImgLoading(imgUrl: widget.item.imgUrl, radius: 16),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.item.name}",
                      style: AppTextDecoration.darkS18
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '${widget.item.email}',
                      style: AppTextDecoration.light154W400S14,
                    ),
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            context
                .read<NewTaskBloc>()
                .add(AsigneeUserOnSelected(userSelected: widget.item));
          },
        ),
      );
    });
  }
}
