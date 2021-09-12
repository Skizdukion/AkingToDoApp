import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/blocs/task/task_event.dart';
import 'package:todo_app/logic/blocs/task/task_state.dart';
import 'package:todo_app/logic/repositories/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc()
      : super(TaskState(
            firebaseTaskRepository: FirebaseTaskRepository(),
            getTaskType: FirebaseTaskRepository.getTaskType));

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is ChangeTaskType) {
      FirebaseTaskRepository.getTaskType = event.taskType;
      yield state.copywith(
          getTaskType: event.taskType,
          firebaseTaskRepository: FirebaseTaskRepository());
    }
  }
}
