import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class ChangeTaskType extends TaskEvent {
  const ChangeTaskType({required this.taskType});
  final int taskType;

  @override
  List<Object> get props => [taskType];
}
