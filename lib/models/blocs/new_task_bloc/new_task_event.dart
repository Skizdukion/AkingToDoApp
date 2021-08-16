import 'package:equatable/equatable.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/models/user.dart';

abstract class NewEvent extends Equatable{
  const NewEvent();

  @override
  List<Object> get props => [];
}

class AsigneeFieldOnTap extends NewEvent{
  const AsigneeFieldOnTap();
  
  @override
  List<Object> get props => [];
}

class AsigneeFieldOnChange extends NewEvent{
  const AsigneeFieldOnChange({required this.fieldValue});
  final String fieldValue;
  @override
  List<Object> get props => [fieldValue];
}

class AsigneeUserOnSelected extends NewEvent{
  const AsigneeUserOnSelected({required this.userSelected});
  final UserModel userSelected;

  @override
  List<Object> get props => [userSelected];
}


class ProjectFieldOnTap extends NewEvent{
  const ProjectFieldOnTap();
  
  @override
  List<Object> get props => [];
}

class ProjectFieldOnChange extends NewEvent{
  const ProjectFieldOnChange({required this.fieldValue});
  final String fieldValue;
  @override
  List<Object> get props => [fieldValue];
}

class ProjectOnSelected extends NewEvent{
  const ProjectOnSelected({required this.projectSelected});
  final ProjectModel projectSelected;

  @override
  List<Object> get props => [projectSelected];
}





