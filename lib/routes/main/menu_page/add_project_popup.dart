import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/providers/firebase_data.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/models/radio_color.dart';
import 'package:todo_app/models/repositories/project_repository.dart';
import 'package:todo_app/routes/main/Popup_page/new_note/color_picker.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class AddProjectMenu extends StatelessWidget {
  AddProjectMenu({ Key? key }) : super(key: key);
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RadioColorList.autoInitial(),
      child: Consumer<RadioColorList>(
        builder: (context, color, child){
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 24),
                  child: Text('Title', style: TextStyle(fontSize: 18, color: Colors.black),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Container(
                    height: 85,
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
                              style: textDarkStyleS18,
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
                ColorPicker(),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: buttonStyleAuthPages,
                      onPressed: (){
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
                        }
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            height: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }
      ),
    );
  }
}
