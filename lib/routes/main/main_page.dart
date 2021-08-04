import 'package:flutter/material.dart';
import 'package:todo_app/routes/main/Popup_page/new_task/add_new_task_page.dart';
import 'package:todo_app/routes/main/Task_page/task_page.dart';
import 'package:todo_app/routes/main/menu_page/project_page.dart';
import 'package:todo_app/routes/main/popup_page/new_check_list/add_new_check_list.dart';

import 'Popup_page/new_note/add_new_note.dart';
import 'bottom_app_bar_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  int _tabselect = 0;

  void _selectedTab(int index) {
    setState(() {
      _tabselect = index;
    });
  }

  @override
   Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: changeTab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddMenu(context),
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
        onTabSelected: _selectedTab, 
        selectedColor: Colors.white,
        unselectedColor: Color.fromRGBO(142, 142, 147, 1),
      ),
      ),
    );
  }

  Widget changeTab(){
    if (_tabselect == 0) return const TaskPage();
    else if (_tabselect == 1) return const ProjectPage();
    else if (_tabselect == 2) return const Center(child: Text('Tab 3'),);
    else if (_tabselect == 3) return const Center(child: Text('Tab 4'),);
    else return const Center(child: Text('There is some bugs'));
  }

  _showAddMenu(context){
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: AddMenu(),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
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
              onPressed: (){
                if (text == 'Add Task'){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewTaskPage()));
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
      margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
