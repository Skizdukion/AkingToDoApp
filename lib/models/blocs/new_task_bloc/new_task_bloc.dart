import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/repositories/project_repository.dart';
import 'package:todo_app/models/repositories/user_repository.dart';

import 'new_task_event.dart';
import 'new_task_state.dart';

class NewTaskBloc extends Bloc<NewEvent, NewTaskState>{
  NewTaskBloc() : super(NewTaskState(projectList: [], userList: []));

  // @override
  // void onTransition(Transition<NewEvent, NewTaskState> transition) {
  //   print(transition.event);
  //   print(transition.nextState);
  //   super.onTransition(transition);
  // }

  @override
  Stream<NewTaskState> mapEventToState(NewEvent event) async*{
    FakeUserRepository _userRepository = FakeUserRepository();
    FakeProjectRepository _projectRepository = FakeProjectRepository();

    if (event is AsigneeFieldOnTap){
      if (state.status == NewTaskStatus.normal) yield state.copyWith(
        userList: _userRepository.getUserListContainString(state.asigneeField),
        status: NewTaskStatus.asigneeSelecting,
      );
    }
    if (event is AsigneeFieldOnChange){
      yield state.copyWith(
        userList: _userRepository.getUserListContainString(event.fieldValue),
        status: NewTaskStatus.asigneeSelecting,
        asigneeField: event.fieldValue,
      );
    }
    if (event is AsigneeUserOnSelected){
      final user = event.userSelected;
      yield state.copyWith(
        user: user,
        status: NewTaskStatus.normal,
      );
    }

    if (event is ProjectFieldOnTap){
      if (state.status == NewTaskStatus.normal) yield state.copyWith(
        projectList: _projectRepository.getProjectListContainString(state.projectField),
        status: NewTaskStatus.projectSelecting,
      );
    }
    if (event is ProjectFieldOnChange){
      yield state.copyWith(
        projectList: _projectRepository.getProjectListContainString(event.fieldValue),
        status: NewTaskStatus.projectSelecting,
        projectField: event.fieldValue,
      );
    }
    if (event is ProjectOnSelected){
      final project = event.projectSelected;
      yield state.copyWith(
        project: project,
        status: NewTaskStatus.normal,
      );
    }
    
  }
}