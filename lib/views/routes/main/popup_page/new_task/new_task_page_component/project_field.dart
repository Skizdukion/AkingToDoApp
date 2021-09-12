import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_event.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_state.dart';
import 'package:todo_app/utils/frequent_use_fuction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectField extends StatefulWidget {
  const ProjectField({
    Key? key,
  }) : super(key: key);

  @override
  _ProjectFieldState createState() => _ProjectFieldState();
}

class _ProjectFieldState extends State<ProjectField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskBloc, NewTaskState>(builder: (context, state) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: (state.project == null) ||
                (state.status == NewTaskStatus.projectSelecting)
            ? Container(
                width: 90.w,
                height: 48.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: TextFormField(
                      initialValue: state.projectField,
                      style:
                          AppTextDecoration.darkW400S16.copyWith(fontSize: 18),
                      readOnly: (state.status == NewTaskStatus.asigneeSelecting)
                          ? true
                          : false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: '  Project',
                        hintStyle: AppTextDecoration.darkW400S16
                            .copyWith(fontSize: 14),
                      ),
                      onTap: () {
                        context.read<NewTaskBloc>().add(ProjectFieldOnTap());
                      },
                      onChanged: (val) {
                        context
                            .read<NewTaskBloc>()
                            .add(ProjectFieldOnChange(fieldValue: val));
                      },
                    ),
                  ),
                ),
              )
            : Container(
                height: 48.h,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          limitString(state.project!.title, 15),
                          style: AppTextDecoration.darkS18.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    context.read<NewTaskBloc>().add(ProjectFieldOnTap());
                  },
                ),
              ),
        elevation: 0.0,
        color: Color.fromRGBO(244, 244, 244, 1),
      );
    });
  }
}
