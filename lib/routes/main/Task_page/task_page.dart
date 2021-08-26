import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/main_page/main_page_bloc.dart';
import 'package:todo_app/models/blocs/main_page/main_page_event.dart';
import 'package:todo_app/models/blocs/main_page/main_page_state.dart';
import 'package:todo_app/routes/main/Task_page/today_task.dart';

import 'month_task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({ Key? key }) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with SingleTickerProviderStateMixin {
  static const List<Tab> mainTabs = <Tab>[
    Tab(text: 'Today'),
    Tab(text: 'Month'),
  ];

  late TabController _tabController;

  int selectIndexInMenuPopup = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: mainTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(249, 96, 96, 1),
            elevation: 2, 
            iconTheme: IconThemeData(color: Colors.white10),
            title: Text('Work List', style: TextStyle(fontSize: 20)),
            centerTitle: true,
            bottom: TabBar(
              tabs: mainTabs,
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3.0,
              indicatorPadding: EdgeInsets.only(bottom: 1, left: 50, right: 50),
              labelStyle:  TextStyle(fontSize: 18),
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    child: Row(
                      children: [
                        Expanded(child: Text('Incomplete Tasks')),
                        Icon(
                          Icons.check_outlined,
                          color: (selectIndexInMenuPopup == 0) ? Color.fromRGBO(126, 211, 33, 1) : Colors.white,
                        ),
                      ],
                    ),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Expanded(child: Text('Complete Tasks')),
                        Icon(
                          Icons.check_outlined,
                          color: (selectIndexInMenuPopup == 1) ? Color.fromRGBO(126, 211, 33, 1) : Colors.white,
                        ),
                      ],
                    ),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Expanded(child: Text('All Tasks')),
                        Icon(
                          Icons.check_outlined,
                          color: (selectIndexInMenuPopup == 2) ? Color.fromRGBO(126, 211, 33, 1) : Colors.white,
                        ),
                      ],
                    ),
                    value: 2,
                  ),
                ],
                icon: const Icon(Icons.tune_outlined, color: Colors.white,),
                iconSize: 30,
                onSelected: (int value){
                  if (selectIndexInMenuPopup != value){
                    selectIndexInMenuPopup = value;
                    context.read<MainPageBloc>().add(ChangeTaskSelectType());                    
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              )
            ],
            shadowColor: Color.fromRGBO(227, 227, 227, 0.5),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              TodayPage(key: Key('Today task page'),),
              MonthPage(key: Key('Month Page'),),
            ],
          ),
        );
      }
    );
  }
}
