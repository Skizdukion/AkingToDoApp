import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_event.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_state.dart';
import 'package:todo_app/utils/frequent_use_fuction.dart';
import 'package:todo_app/views/widgets/image_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AsigneeField extends StatefulWidget {
  const AsigneeField({
    Key? key,
  }) : super(key: key);

  @override
  _AsigneeFieldState createState() => _AsigneeFieldState();
}

class _AsigneeFieldState extends State<AsigneeField> {
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
        child: (state.user == null) ||
                (state.status == NewTaskStatus.asigneeSelecting)
            ? Container(
                width: 90.w,
                height: 48.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: TextFormField(
                      initialValue: state.asigneeField,
                      style:
                          AppTextDecoration.darkW400S16.copyWith(fontSize: 18),
                      autofocus: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: '  Asignee',
                        hintStyle: AppTextDecoration.darkW400S16
                            .copyWith(fontSize: 14),
                      ),
                      onTap: () {
                        context.read<NewTaskBloc>().add(AsigneeFieldOnTap());
                      },
                      onChanged: (val) {
                        context
                            .read<NewTaskBloc>()
                            .add(AsigneeFieldOnChange(fieldValue: val));
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
                        ImgLoading(imgUrl: state.user!.imgUrl, radius: 20.r),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          limitString(state.user!.name, 15),
                          style: AppTextDecoration.darkS18.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    context.read<NewTaskBloc>().add(AsigneeFieldOnTap());
                  },
                ),
              ),
        elevation: 0.0,
        color: Color.fromRGBO(244, 244, 244, 1),
      );
    });
  }
}
