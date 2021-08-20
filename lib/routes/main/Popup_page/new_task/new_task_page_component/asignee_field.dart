import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/models/blocs/new_task/new_task_event.dart';
import 'package:todo_app/models/blocs/new_task/new_task_state.dart';
import 'package:todo_app/widgets/const_decoration.dart';


class AsigneeField extends StatefulWidget {
  const AsigneeField({ Key? key,}) : super(key: key);

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
    return  BlocBuilder<NewTaskBloc, NewTaskState>(
      builder: (context, state){
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: (state.user == null)||(state.status == NewTaskStatus.asigneeSelecting) ? Container(
            width: 90,
            height: 48,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: TextFormField(
                  initialValue: state.asigneeField,
                  style: textDarkStyleW400S16.copyWith(fontSize: 18),
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: '  Asignee',
                    hintStyle: textDarkStyleW400S16.copyWith(fontSize: 14),
                  ),
                  onTap: (){
                    context.read<NewTaskBloc>().add(AsigneeFieldOnTap());
                  },
                  onChanged: (val){
                    context.read<NewTaskBloc>().add(AsigneeFieldOnChange(fieldValue: val));
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
                    CircleAvatar(
                      radius: 20, 
                      backgroundImage: NetworkImage('${state.user!.imgUrl}'),                     
                    ),
                    const SizedBox(width: 10,),
                    Text("${state.user!.name}", style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold, fontSize: 14),),
                  ],
                ),
              ),
              onTap: (){
                context.read<NewTaskBloc>().add(AsigneeFieldOnTap());
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