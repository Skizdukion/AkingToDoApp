import 'package:equatable/equatable.dart';
import 'package:todo_app/logic/repositories/task_repository.dart';

class TaskState extends Equatable {
  const TaskState(
      {required this.firebaseTaskRepository, required this.getTaskType});
  final FirebaseTaskRepository firebaseTaskRepository;
  final int getTaskType;

  TaskState copywith(
      {FirebaseTaskRepository? firebaseTaskRepository, int? getTaskType}) {
    return TaskState(
        firebaseTaskRepository:
            firebaseTaskRepository ?? this.firebaseTaskRepository,
        getTaskType: getTaskType ?? this.getTaskType);
  }

  List<Object?> get props => [firebaseTaskRepository];
}
