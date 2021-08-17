import 'package:equatable/equatable.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/models/user.dart';

abstract class NewTaskEvent extends Equatable{
  const NewTaskEvent();

  @override
  List<Object> get props => [];
}

class AsigneeFieldOnTap extends NewTaskEvent{
  const AsigneeFieldOnTap();
  
  @override
  List<Object> get props => [];
}

class AsigneeFieldOnChange extends NewTaskEvent{
  const AsigneeFieldOnChange({required this.fieldValue});
  final String fieldValue;
  @override
  List<Object> get props => [fieldValue];
}

class AsigneeUserOnSelected extends NewTaskEvent{
  const AsigneeUserOnSelected({required this.userSelected});
  final UserModel userSelected;

  @override
  List<Object> get props => [userSelected];
}


class ProjectFieldOnTap extends NewTaskEvent{
  const ProjectFieldOnTap();
  
  @override
  List<Object> get props => [];
}

class ProjectFieldOnChange extends NewTaskEvent{
  const ProjectFieldOnChange({required this.fieldValue});
  final String fieldValue;
  @override
  List<Object> get props => [fieldValue];
}

class ProjectOnSelected extends NewTaskEvent{
  const ProjectOnSelected({required this.projectSelected});
  final ProjectModel projectSelected;

  @override
  List<Object> get props => [projectSelected];
}

class DueDateOnChange extends NewTaskEvent{
  const DueDateOnChange({required this.dueDate});
  final DateTime dueDate;

  @override
  List<Object> get props => [dueDate];
}

class MemberListOnChange extends NewTaskEvent{
  const MemberListOnChange({required this.memberList});
  final List<UserModel> memberList;

  @override
  List<Object> get props => [memberList];
}





