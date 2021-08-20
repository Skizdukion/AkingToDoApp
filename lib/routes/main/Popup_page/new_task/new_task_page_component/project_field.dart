import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/models/blocs/new_task/new_task_event.dart';
import 'package:todo_app/models/blocs/new_task/new_task_state.dart';
import 'package:todo_app/widgets/const_decoration.dart';


class ProjectField extends StatefulWidget {
  const ProjectField({ Key? key,}) : super(key: key);

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
    return  BlocBuilder<NewTaskBloc, NewTaskState>(
      builder: (context, state){
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: (state.project == null) ? Container(
            width: 90,
            height: 48,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: TextFormField(
                  initialValue: state.projectField,
                  style: textDarkStyleW400S16.copyWith(fontSize: 18),
                  readOnly: (state.status == NewTaskStatus.asigneeSelecting) ? true : false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: '  Project',
                    hintStyle: textDarkStyleW400S16.copyWith(fontSize: 14),
                  ),
                  onTap: (){
                    context.read<NewTaskBloc>().add(ProjectFieldOnTap());
                  },
                  onChanged: (val){
                    context.read<NewTaskBloc>().add(ProjectFieldOnChange(fieldValue: val));
                  },
                ),
              ),
            ),
          ) : Container(
            height: 48,
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10,),
                    Text("${state.project!.title}", style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold, fontSize: 14),),
                  ],
                ),
              ),
              onTap: (){
                context.read<NewTaskBloc>().add(ProjectFieldOnTap());
              },
            ),
          ),
          elevation: 0.0,
          color: Color.fromRGBO(244, 244, 244, 1),
        );
      }
    );
  }
}