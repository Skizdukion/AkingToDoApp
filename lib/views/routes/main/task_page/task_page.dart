import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/blocs/task/task_bloc.dart';
import 'package:todo_app/logic/blocs/task/task_event.dart';
import 'package:todo_app/logic/blocs/task/task_state.dart';
import 'package:todo_app/views/routes/main/task_page/component/today_task.dart';
import 'package:todo_app/views/routes/main/task_page/component/month_task.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(),
      child: TaskPageBody(),
    );
  }
}

class TaskPageBody extends StatefulWidget {
  const TaskPageBody({Key? key}) : super(key: key);

  @override
  _TaskPageBodyState createState() => _TaskPageBodyState();
}

class _TaskPageBodyState extends State<TaskPageBody>
    with SingleTickerProviderStateMixin {
  static const List<Tab> mainTabs = <Tab>[
    Tab(text: 'Today'),
    Tab(text: 'Month'),
  ];

  late TabController _tabController;
  late TaskBloc taskBloc;

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
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
            indicatorPadding: EdgeInsets.only(bottom: 1.h, left: 50.w, right: 50.h),
            labelStyle: TextStyle(fontSize: 18),
            labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
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
                        color: (state.getTaskType == 0)
                            ? Color.fromRGBO(126, 211, 33, 1)
                            : Colors.white,
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
                        color: (state.getTaskType == 1)
                            ? Color.fromRGBO(126, 211, 33, 1)
                            : Colors.white,
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
                        color: (state.getTaskType == 2)
                            ? Color.fromRGBO(126, 211, 33, 1)
                            : Colors.white,
                      ),
                    ],
                  ),
                  value: 2,
                ),
              ],
              icon: const Icon(
                Icons.tune_outlined,
                color: Colors.white,
              ),
              iconSize: 30,
              onSelected: (int value) {
                if (state.getTaskType != value) {
                  context.read<TaskBloc>().add(ChangeTaskType(taskType: value));
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
            )
          ],
          shadowColor: Color.fromRGBO(227, 227, 227, 0.5),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            TodayPage(
              key: Key('Today task page'),
            ),
            MonthPage(
              key: Key('Month Page'),
            ),
          ],
        ),
      );
    });
  }
}
