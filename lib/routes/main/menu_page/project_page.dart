import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/project_repository.dart';
import 'package:todo_app/routes/main/menu_page/project_item.dart';
import 'package:todo_app/widgets/const_decoration.dart';
import 'add_project_popup.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({ Key? key }) : super(key: key);

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
          title: Text('Projects', style: TextStyle(fontSize: 20, color: Colors.black)),
          centerTitle: true,
        ),
        body: ProjectPageBody(),
      ),
    );
  }
}

class ProjectPageBody extends StatefulWidget {
  const ProjectPageBody({ Key? key }) : super(key: key);

  @override
  _ProjectPageBodyState createState() => _ProjectPageBodyState();
}

class _ProjectPageBodyState extends State<ProjectPageBody> {

  // late ProjectRepository _projectRepository;
  // late ValueNotifier<List<ProjectModel>> _projectlist;
  late Stream<List<ProjectModel>> projectList;
  late FirebaseProjectRepository _firebaseRepository = FirebaseProjectRepository();


  @override
  void initState() {
    // _projectRepository = FakeProjectRepository();
    // _projectlist = ValueNotifier([]..addAll(_projectRepository.getPorjectList()));
    projectList = _firebaseRepository.getStreamProjectList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 16, left: 16),
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
          return ListView(
            children: [
              Wrap(
                spacing: 30,
                runSpacing: 30,
                children: [
                  for(var index in data) ProjectItem(item: index,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: _showAddMenu,
                        style: buttonStyleMenuPage,
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]
          );
        }
      )
    );
  }

  _showAddMenu() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            backgroundColor: Colors.white,
            child: AddProjectMenu(),
          )
        );
    });
  }
}

// @override
// Widget build(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 50, right: 16, left: 16),
//     child: ValueListenableBuilder<List<ProjectModel>>(
//       valueListenable: _projectlist,
//       builder: (context, value, _){
//         return ListView(
//           children: [
//             Wrap(
//               spacing: 30,
//               runSpacing: 30,
//               children: [
//                 for(var index in value) ProjectItem(item: index,),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   child: SizedBox(
//                     width: 80,
//                     height: 80,
//                     child: ElevatedButton(
//                       onPressed: _showAddMenu,
//                       style: buttonStyleMenuPage,
//                       child: Center(
//                         child: Text(
//                           '+',
//                           style: TextStyle(color: Colors.white, fontSize: 24),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       }
//     ),
//   );
// }

