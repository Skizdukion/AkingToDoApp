import 'package:equatable/equatable.dart';

abstract class MainPageState extends Equatable {
  const MainPageState();
}

class TaskScreen extends MainPageState {
  const TaskScreen();

  List<Object?> get props => [];
}

class ProjectScreen extends MainPageState {
  const ProjectScreen();

  List<Object?> get props => [];
}

class QuickNoteScreen extends MainPageState {
  const QuickNoteScreen();

  List<Object?> get props => [];
}

class ProfileScreen extends MainPageState {
  const ProfileScreen();

  List<Object?> get props => [];
}

class Error extends MainPageState {
  const Error();

  @override
  List<Object?> get props => [];
}

class Loading extends MainPageState {
  const Loading();

  @override
  List<Object?> get props => [];
}

class AddingItem extends MainPageState {
  const AddingItem();

  @override
  List<Object?> get props => [];
}
