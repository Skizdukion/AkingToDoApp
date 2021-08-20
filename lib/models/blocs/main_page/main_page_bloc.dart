import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/main_page/main_page_event.dart';
import 'package:todo_app/models/blocs/main_page/main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState>{
  MainPageBloc() : super(TaskScreen());

  @override
  Stream<MainPageState> mapEventToState(MainPageEvent event) async*{
    if (event is SwitchPage){
      yield* _mapSwitchScreeen(event, state);
    }
    if ((event is AddNewTask)||(event is ChangeTaskSelectType)){
      yield* _reloadTaskPage(event, state) ;
    }

  }

  Stream<MainPageState> _reloadTaskPage(MainPageEvent event, MainPageState state) async*{
    if (state is TaskScreen){
      try{
        yield Loading();
      } on Exception{
        yield Error();
      }
    }
  }

  Stream<MainPageState> _mapSwitchScreeen(SwitchPage event, MainPageState state) async*{
    try {
      if ((event.pageIndex == 0)) yield TaskScreen();
      if (event.pageIndex == 1) yield ProjectScreen();
      else if (event.pageIndex == 2) yield QuickNoteScreen();
      else if (event.pageIndex == 3) yield ProfileScreen();
    } on Exception {
      yield Error();
    }
  }
}