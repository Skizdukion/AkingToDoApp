import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/main_page/main_page_bloc.dart';
import 'package:todo_app/models/blocs/main_page/main_page_event.dart';
import 'package:todo_app/models/blocs/main_page/main_page_state.dart';
import 'package:todo_app/routes/main/Popup_page/new_task/add_new_task_page.dart';
import 'package:todo_app/routes/main/Task_page/task_page.dart';
import 'package:todo_app/routes/main/menu_page/project_page.dart';
import 'package:todo_app/routes/main/popup_page/new_check_list/add_new_check_list.dart';
import 'package:todo_app/routes/main/profile_page/profile_page.dart';
import 'package:todo_app/routes/main/quick_note_page/quick_note_page.dart';

import 'Popup_page/new_note/add_new_note.dart';
import 'bottom_app_bar_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  @override
   Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainPageBloc(),
      child: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (context, state){
          return MainScreen();
        }
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state){
        return SafeArea(
          child: Scaffold(
            body: MainScreenBody(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddMenu(),
              tooltip: "Centre FAB",
              child: Container(
                margin: EdgeInsets.all(15.0),
                child: Icon(Icons.add),
              ),
              elevation: 4.0,
              backgroundColor: Color.fromRGBO(249, 96, 96, 1),
            ),
            bottomNavigationBar: FABBottomAppBar(
            items: [
              FABBottomAppBarItem(iconData: Icons.check_circle_rounded, text: 'My task'),
              FABBottomAppBarItem(iconData: Icons.grid_view_rounded, text: 'Menu'),
              FABBottomAppBarItem(iconData: Icons.event_note_outlined , text: 'Quick'),
              FABBottomAppBarItem(iconData: Icons.person, text: 'Profile'),
            ], 
            centerItemText: '', 
            backgroundColor: Color.fromRGBO(41, 46, 78, 1),
            onTabSelected: (index){
              context.read<MainPageBloc>().add(SwitchPage(pageIndex: index));
            }, 
            selectedColor: Colors.white,
            unselectedColor: Color.fromRGBO(142, 142, 147, 1),
          ),
          ),
        );
      }
    );
  }

  _showAddMenu() async{
    String? command = await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          backgroundColor: Colors.white,
          child: AddMenu(),
        )
      );
    }); 
    if (command == 'task'){
      context.read<MainPageBloc>().add(AddNewTask());
    }   
    if (command == 'quicknote'){
      context.read<MainPageBloc>().add(AddNewQuickNote());
    }  
    if (command == 'checklist'){
      context.read<MainPageBloc>().add(AddNewCheckList());
    }  
  }  
  
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state){
        if (state is TaskScreen) return TaskPage();
        if (state is ProjectScreen) return ProjectPage();
        if (state is QuickNoteScreen) return QuickNotePage();
        if (state is ProfileScreen) return ProfilePage();
        if (state is Loading) return Center(child: CircularProgressIndicator(),);
        else return Container();
      } 
    );
  }
}

class AddMenuItem extends StatelessWidget {
  const AddMenuItem({ Key? key, required this.text }) : super(key: key);
  final text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Column(
        children: [
          Center(
            child: TextButton(
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onPressed: () async{
                if (text == 'Add Task'){
                  bool? isAdd = await Navigator.push(context, MaterialPageRoute(builder: (context) => NewTaskPage()));
                  if (isAdd == true) Navigator.pop(context, 'task');
                }
                if (text == 'Add Quick Note'){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewNotePage()));
                }
                if (text == 'Add Check List'){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCheckListPage()));
                }
              },
            ),
          ),
          Divider(thickness: 1, color: Color.fromRGBO(228, 228, 228, 1,)),
        ],
      ),
    );
  }
}

class AddMenu extends StatelessWidget {
  const AddMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          AddMenuItem(text: 'Add Task',),
          AddMenuItem(text: 'Add Quick Note',),
          AddMenuItem(text: 'Add Check List',),
        ],
      ),
      height: 220,
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

