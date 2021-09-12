import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/models/project.dart';
import 'package:todo_app/logic/repositories/project_repository.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectListPicker extends StatefulWidget {
  const ProjectListPicker({Key? key, required this.projectList})
      : super(key: key);
  final List<String> projectList;

  @override
  _ProjectListPickerState createState() => _ProjectListPickerState();
}

class _ProjectListPickerState extends State<ProjectListPicker> {
  ValueNotifier<String> searchString = ValueNotifier('');
  late Stream<List<ProjectModel>> projectStreamList;
  late Future<List<ProjectModel>> projectFutureList;
  TextEditingController _textEditingController = TextEditingController();
  List<ProjectModel> projectList = [];

  @override
  void initState() {
    projectFutureList = FirebaseProjectRepository()
        .convertListStringToListProjectModel(widget.projectList);
    projectStreamList = FirebaseProjectRepository().getStreamProjectList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProjectModel>>(
        future: projectFutureList,
        builder: (context, memberListSnapshot) {
          return Container(
            height: 400.h,
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: TextFormField(
                    controller: _textEditingController,
                    style: AppTextDecoration.darkW400S16.copyWith(fontSize: 18),
                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'User name',
                    ),
                    onChanged: (val) {
                      searchString.value = val;
                    },
                  ),
                ),
                Container(
                    height: 280.h,
                    child: StreamBuilder<List<ProjectModel>>(
                        stream: projectStreamList,
                        builder: (context, userListSnapshot) {
                          if (userListSnapshot.hasError ||
                              memberListSnapshot.hasError) {
                            return Center(
                              child: Text('Error'),
                            );
                          }
                          if (!userListSnapshot.hasData ||
                              !memberListSnapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          projectList = memberListSnapshot.data!;
                          return ValueListenableBuilder<String>(
                            valueListenable: searchString,
                            builder: (context, value, _) {
                              List<ProjectModel> userList =
                                  FirebaseProjectRepository()
                                      .getProjectListContainString(
                                          searchString.value,
                                          userListSnapshot.data!);
                              return ListView.builder(
                                itemCount: userList.length,
                                itemBuilder: (context, index) {
                                  return ProjectItemInAddMember(
                                    item: userList[index],
                                    addProject: addProjectToList,
                                    unAddProject: unAddProjectToList,
                                    isSelected:
                                        checkSelected(userList[index].id),
                                  );
                                },
                              );
                            },
                          );
                        })),
                SizedBox(
                  height: 10.h,
                ),
                StrechButton(
                  text: 'Done',
                  onPressed: () {
                    Navigator.pop(context, projectList);
                  },
                  buttonStyle: AppButtonDecoration.authenticate2,
                  horizontalPadding: 80.w,
                ),
              ],
            ),
          );
        });
  }

  bool checkSelected(String id) {
    bool returnBool = false;
    for (var item in projectList) {
      if (item.id == id) {
        returnBool = true;
        break;
      }
    }
    return returnBool;
  }

  void addProjectToList(ProjectModel item) {
    projectList.add(item);
  }

  void unAddProjectToList(ProjectModel item) {
    ProjectModel? removeMember;
    for (var member in projectList) {
      if (member.id == item.id) removeMember = member;
    }
    projectList.remove(removeMember);
  }
}

class ProjectItemInAddMember extends StatefulWidget {
  const ProjectItemInAddMember(
      {Key? key,
      required this.item,
      required this.addProject,
      required this.unAddProject,
      this.isSelected = false})
      : super(key: key);
  final ProjectModel item;
  final ValueSetter<ProjectModel> addProject;
  final ValueSetter<ProjectModel> unAddProject;
  final bool isSelected;
  @override
  _ProjectItemInAddMemberState createState() => _ProjectItemInAddMemberState();
}

class _ProjectItemInAddMemberState extends State<ProjectItemInAddMember> {
  late bool isAdd;

  @override
  void initState() {
    isAdd = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Container(
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: widget.item.color,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.item.title}",
                  style: AppTextDecoration.darkS18
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '${widget.item.totalTask}',
                  style: AppTextDecoration.light154W400S14,
                ),
              ],
            ),
            Spacer(),
            Checkbox(
              checkColor: Colors.white,
              value: isAdd,
              onChanged: (bool? val) {
                setState(() {
                  isAdd = val!;
                });
                if (val == true) {
                  widget.addProject(widget.item);
                } else
                  widget.unAddProject(widget.item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
