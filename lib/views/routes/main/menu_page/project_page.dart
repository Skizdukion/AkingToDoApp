import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_state.dart';
import 'package:todo_app/logic/models/project.dart';
import 'package:todo_app/views/routes/main/menu_page/project_item.dart';
import 'add_project_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0,
          title: Text('Projects',
              style: TextStyle(fontSize: 20, color: Colors.black)),
          centerTitle: true,
        ),
        body: ProjectPageBody(),
      ),
    );
  }
}

class ProjectPageBody extends StatefulWidget {
  const ProjectPageBody({Key? key}) : super(key: key);

  @override
  _ProjectPageBodyState createState() => _ProjectPageBodyState();
}

class _ProjectPageBodyState extends State<ProjectPageBody> {
  late Stream<List<ProjectModel>> projectList;
  late AuthState authState;

  @override
  void initState() {
    authState = BlocProvider.of<AuthBloc>(context).state;
    // print(authState.toString());
    if (authState is LoggeddUser) {
      projectList =
          (authState as LoggeddUser).firebaseDataProvider.streamFromFirebase.allProjectList;
    } else {
      throw ("access denied ${authState.toString()}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 50.h, right: 16.w, left: 16.w),
        child: StreamBuilder<List<ProjectModel>>(
            stream: projectList,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final data = snapshot.requireData;
              return ListView(children: [
                Wrap(
                  spacing: 30.w,
                  runSpacing: 30.h,
                  children: [
                    for (var index in data)
                      ProjectItem(
                        item: index,
                      ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: ElevatedButton(
                          onPressed: _showAddMenu,
                          style: AppButtonDecoration.menu,
                          child: Center(
                            child: Text(
                              '+',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]);
            }));
  }

  _showAddMenu() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                backgroundColor: Colors.white,
                child: AddProjectMenu(),
                insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
              ));
        });
  }
}
