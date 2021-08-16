import 'package:equatable/equatable.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/models/user.dart';

class NewTaskState extends Equatable{
  const NewTaskState({
    this.project,
    this.user,
    this.asigneeField = '',
    this.projectField = '',
    required this.projectList,
    required this.userList,
    this.status = NewTaskStatus.normal,
  });
  final String asigneeField;
  final String projectField;
  final List<UserModel> userList;
  final List<ProjectModel> projectList;
  final UserModel? user;
  final ProjectModel? project;
  final NewTaskStatus status;
  
  NewTaskState copyWith({
    String? asigneeField,
    String? projectField,
    List<UserModel>? userList,
    List<ProjectModel>? projectList,
    UserModel? user,
    ProjectModel? project,
    NewTaskStatus? status,
  }) {
    return NewTaskState(
      asigneeField: asigneeField ?? this.asigneeField,
      projectField: projectField ?? this.projectField,
      userList: userList ?? this.userList,
      projectList: projectList ?? this.projectList,
      user: user ?? this.user,
      project: project ?? this.project,
      status: status ?? this.status,
    );
  }
      
  @override
  List<Object?> get props => [asigneeField, projectField, userList.length, projectList.length, user, project, status];
}


enum NewTaskStatus{
  normal,
  asigneeSelecting,
  projectSelecting,
  imagePicking,
  dateTimePicking,
  addMember,
  validation,
}
