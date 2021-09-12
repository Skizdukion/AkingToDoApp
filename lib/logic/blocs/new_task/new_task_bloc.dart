import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/models/project.dart';
import 'package:todo_app/logic/models/user.dart';
import 'package:todo_app/logic/repositories/project_repository.dart';
import 'package:todo_app/logic/repositories/user_repository.dart';

import 'new_task_event.dart';
import 'new_task_state.dart';

class NewTaskBloc extends Bloc<NewTaskEvent, NewTaskState> {
  NewTaskBloc()
      : super(NewTaskState(projectList: [], userList: [], memberList: []));

  // @override
  // void onTransition(Transition<NewEvent, NewTaskState> transition) {
  //   print(transition.event);
  //   print(transition.nextState);
  //   super.onTransition(transition);
  // }

  @override
  Stream<NewTaskState> mapEventToState(NewTaskEvent event) async* {
    FirebaseProjectRepository firebaseProjectRepository =
        FirebaseProjectRepository();
    FirebaseUserRepository firebaseUserRepository = FirebaseUserRepository();
    List<ProjectModel> allProjectList =
        await firebaseProjectRepository.getProjectList();
    List<UserModel> allUserList = await firebaseUserRepository.getUserList();

    if (event is AsigneeFieldOnTap) {
      if (state.status == NewTaskStatus.normal)
        yield state.copyWith(
          userList: firebaseUserRepository.getUserListContainString(
              state.asigneeField, allUserList),
          status: NewTaskStatus.asigneeSelecting,
        );
    }
    if (event is AsigneeFieldOnChange) {
      yield state.copyWith(
        userList: firebaseUserRepository.getUserListContainString(
            event.fieldValue, allUserList),
        status: NewTaskStatus.asigneeSelecting,
        asigneeField: event.fieldValue,
      );
    }
    if (event is AsigneeUserOnSelected) {
      yield state.copyWith(
        user: event.userSelected,
        status: NewTaskStatus.normal,
      );
    }

    if (event is ProjectFieldOnTap) {
      if (state.status == NewTaskStatus.normal) {
        yield state.copyWith(
          projectList: firebaseProjectRepository.getProjectListContainString(
              state.projectField, allProjectList),
          status: NewTaskStatus.projectSelecting,
        );
      }
    }
    if (event is ProjectFieldOnChange) {
      yield state.copyWith(
        projectList: firebaseProjectRepository.getProjectListContainString(
            event.fieldValue, allProjectList),
        status: NewTaskStatus.projectSelecting,
        projectField: event.fieldValue,
      );
    }
    if (event is ProjectOnSelected) {
      yield state.copyWith(
        project: event.projectSelected,
        status: NewTaskStatus.normal,
      );
    }
    if (event is DueDateOnChange) {
      yield state.copyWith(
        dueDate: event.dueDate,
      );
    }
    if (event is MemberListOnChange) {
      yield state.copyWith(
        memberList: event.memberList,
      );
    }
    if (event is Verify) {}
  }
}
