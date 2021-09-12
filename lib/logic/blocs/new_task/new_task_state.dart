import 'package:equatable/equatable.dart';
import 'package:todo_app/logic/models/project.dart';
import 'package:todo_app/logic/models/user.dart';

class NewTaskState extends Equatable {
  const NewTaskState({
    this.project,
    this.user,
    this.asigneeField = '',
    this.projectField = '',
    required this.projectList,
    required this.userList,
    required this.memberList,
    this.error = '',
    this.status = NewTaskStatus.normal,
    this.dueDate,
  });
  final String asigneeField;
  final String projectField;
  final List<UserModel> userList;
  final List<ProjectModel> projectList;
  final UserModel? user;
  final ProjectModel? project;
  final DateTime? dueDate;
  final NewTaskStatus status;
  final List<UserModel> memberList;
  final String error;

  NewTaskState copyWith(
      {String? asigneeField,
      String? projectField,
      List<UserModel>? memberList,
      List<UserModel>? userList,
      List<ProjectModel>? projectList,
      UserModel? user,
      ProjectModel? project,
      NewTaskStatus? status,
      String? error,
      DateTime? dueDate}) {
    return NewTaskState(
      asigneeField: asigneeField ?? this.asigneeField,
      projectField: projectField ?? this.projectField,
      userList: userList ?? this.userList,
      projectList: projectList ?? this.projectList,
      user: user ?? this.user,
      project: project ?? this.project,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      memberList: memberList ?? this.memberList,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        asigneeField,
        projectField,
        userList.length,
        projectList.length,
        user,
        project,
        status,
        dueDate,
        memberList
      ];
}

enum NewTaskStatus {
  normal,
  asigneeSelecting,
  projectSelecting,
  dueDatePicking,
  imagePicking,
  dateTimePicking,
  addMember,
  validation,
}
