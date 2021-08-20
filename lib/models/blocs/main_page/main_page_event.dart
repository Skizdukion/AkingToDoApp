import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable{
  const MainPageEvent();

  @override
  List<Object> get props => [];
}

class SwitchPage extends MainPageEvent{
  const SwitchPage({required this.pageIndex});
  final int pageIndex;
  
  @override
  List<Object> get props => [pageIndex];
}

class AddNewTask extends MainPageEvent{
  const AddNewTask();
}

class AddNewQuickNote extends MainPageEvent{
  const AddNewQuickNote();
}

class AddNewCheckList extends MainPageEvent{
  const AddNewCheckList();
}

class FinishReload extends MainPageEvent{
  const FinishReload({required this.pageIndex});
  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}

class ChangeTaskSelectType extends MainPageEvent{
  const ChangeTaskSelectType();
}

