import 'package:flutter/material.dart';
import 'package:todo_app/routes/main/Task_page/task_page.dart';

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
          onPressed: (){},
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
    else if (_tabselect == 1) return const Center(child: Text('Tab 2'),);
    else if (_tabselect == 2) return const Center(child: Text('Tab 3'),);
    else if (_tabselect == 3) return const Center(child: Text('Tab 4'),);
    else return const Center(child: Text('There is some bugs'));
  }
}