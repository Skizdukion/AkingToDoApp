import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/global/error/create_string_error.dart';
import 'package:todo_app/logic/models/project.dart';
import 'package:todo_app/logic/models/radio_color.dart';
import 'package:todo_app/logic/providers/firebase_data.dart';
import 'package:todo_app/logic/repositories/project_repository.dart';
import 'package:todo_app/views/routes/main/popup_page/new_note/color_picker.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProjectMenu extends StatefulWidget {
  AddProjectMenu({Key? key}) : super(key: key);

  @override
  _AddProjectMenuState createState() => _AddProjectMenuState();
}

class _AddProjectMenuState extends State<AddProjectMenu> {
  final TextEditingController _titleController = TextEditingController();
  ValueNotifier<String> error = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RadioColorList.autoInitial(),
      child: Consumer<RadioColorList>(builder: (context, color, child) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(left: 24.w, top: 24.h),
                child: Text(
                  'Title',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Container(
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Center(
                          child: TextFormField(
                            style: AppTextDecoration.darkS18,
                            minLines: 6,
                            maxLines: 6,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            controller: _titleController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder<String>(
                  valueListenable: error,
                  builder: (context, bool, child) {
                    return Center(
                        child: Text(
                      error.value,
                      style: TextStyle(color: Colors.red),
                    ));
                  }),
              SizedBox(
                height: 10.h,
              ),
              ColorPicker(),
              SizedBox(
                height: 25.h,
              ),
              StrechButton(
                text: 'Done',
                onPressed: () {
                  if (_titleController.text != '') {
                    print(color.getSelectColor());
                    ProjectModel addProject = ProjectModel(
                      title: _titleController.text,
                      id: 'this field is not neccessary',
                      color: color.getSelectColor(),
                      userId: FirebaseDataProvider.uid,
                    );
                    FirebaseProjectRepository().addProject(addProject);
                    Navigator.pop(context);
                  } else {
                    error.value = ErrorInCreate.emptyTitleProject;
                  }
                },
                buttonStyle: AppButtonDecoration.authenticate2,
                horizontalPadding: 25.w,
              )
            ],
          ),
          height: 400.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}
