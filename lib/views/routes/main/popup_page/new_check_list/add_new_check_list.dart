import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/global/error/create_string_error.dart';
import 'package:todo_app/logic/models/check.dart';
import 'package:todo_app/logic/models/quick_note.dart';
import 'package:todo_app/logic/models/radio_color.dart';
import 'package:todo_app/logic/providers/firebase_data.dart';
import 'package:todo_app/logic/repositories/quick_note_repository.dart';
import 'package:todo_app/views/routes/main/popup_page/new_check_list/title_box_check_list.dart';
import 'package:todo_app/views/routes/main/popup_page/new_note/color_picker.dart';
import 'package:todo_app/views/utils/extension/snack_bar.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'check_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewCheckListPage extends StatefulWidget {
  const NewCheckListPage({Key? key}) : super(key: key);

  @override
  _NewCheckListPageState createState() => _NewCheckListPageState();
}

class _NewCheckListPageState extends State<NewCheckListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(249, 96, 96, 1),
          elevation: 0,
          title: Text('Add Check List', style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),
        body: Container(
          child: NewCheckListForm(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class NewCheckListForm extends StatefulWidget {
  const NewCheckListForm({Key? key}) : super(key: key);

  @override
  _NewCheckListFormState createState() => _NewCheckListFormState();
}

class _NewCheckListFormState extends State<NewCheckListForm> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CheckListModel>(
            create: (_) => CheckListModel.fakeData()),
        ChangeNotifierProvider<RadioColorList>(
            create: (_) => RadioColorList.autoInitial()),
      ],
      child: Consumer2<CheckListModel, RadioColorList>(
          builder: (context, checkList, color, child) {
        return Padding(
            padding: EdgeInsets.only(
                top: 10.h,
                left: 16.w,
                right: 16.w,
                bottom: getBottomPadding(checkList)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  TilteBoxCheckList(
                    titleController: _titleController,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ColorPicker(),
                  SizedBox(
                    height: 20.h,
                  ),
                  CheckList(),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        checkList.addAutoCheckNote();
                      },
                      child: Text(
                        '+ Add new item',
                        style: AppTextDecoration.darkS18.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  StrechButton(
                    text: 'Done',
                    onPressed: () {
                      if (_titleController.text.isNotEmpty) {
                        FirebaseQuickNoteRepository _quickNoteRepository =
                            FirebaseQuickNoteRepository();
                        _quickNoteRepository.addQuickNote(QuickNoteModel(
                          checkList: checkList.checkList,
                          id: 'this field is unneccessary for firebase',
                          title: _titleController.text,
                          color: color.getSelectColor(),
                          userId: FirebaseDataProvider.uid,
                        ));
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            ExpandedSnackBar.failureSnackBar(
                                context, ErrorInCreate.emptyTitleCheckList));
                      }
                    },
                    buttonStyle: AppButtonDecoration.authenticate2,
                    horizontalPadding: 25.w,
                  )
                ],
              ),
            ));
      }),
    );
  }

  double getBottomPadding(CheckListModel checkList) {
    if (MediaQuery.of(context).size.height -
            450.h -
            checkList.checkList.length * 50.h >
        60.h) {
      return MediaQuery.of(context).size.height -
          450.h -
          checkList.checkList.length * 50.h;
    } else
      return 20.h;
  }
}
