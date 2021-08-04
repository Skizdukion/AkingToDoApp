import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/models/radio_color.dart';
import 'package:todo_app/models/repositories/project_repository.dart';
import 'package:todo_app/routes/main/Popup_page/new_note/color_picker.dart';
import 'package:todo_app/widgets/const_decoration.dart';

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

  late ProjectRepository _projectRepository;
  late List<ProjectModel> _projectlist;

  @override
  void initState() {
    _projectRepository = FakeProjectRepository();
    _projectlist = _projectRepository.getPorjectList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 16, left: 16),
      child: ListView(
        children: [
          Wrap(
            spacing: 30,
            runSpacing: 30,
            children: [
              for(var index in _projectlist) ProjectItem(item: index,),
              SizedBox(
                width: 80,
                height: 80,
                child: ElevatedButton(
                  onPressed: addNewProject,
                  style: buttonStyleMenuPage,
                  child: Center(
                    child: Text(
                      '+',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addNewProject(){
    _projectRepository.addProject(ProjectModel(title: 'Generate Project', projectId: '${_projectlist.length + 1}'));
    setState(() {
      
    });
  }
}

class AddProjectMenu extends StatelessWidget {
  const AddProjectMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RadioColorList.autoInitial(),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 24),
              child: Text('Title', style: TextStyle(fontSize: 18, color: Colors.black),),
            ),
            SizedBox(height: 85,),
            ColorPicker(),
          ],
        ),
        width: 350,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class ProjectItem extends StatelessWidget {
  const ProjectItem({ Key? key, required this.item }) : super(key: key);
  final ProjectModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 180,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Color.fromRGBO(219, 221, 239, 1),
              radius: 13,
              child: Icon(
                Icons.circle,
                color: item.color,
                size: 17,
              ),
            ),
            SizedBox(height: 50,),
            Text('${item.title}', style: TextStyle(fontSize: 18, color: Colors.black),),
            SizedBox(height: 20,),
            Text('${item.totalTask} Tasks', style: textLight154StyleW400S14.copyWith(fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
