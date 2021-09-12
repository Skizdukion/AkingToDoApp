import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/global/error/create_string_error.dart';
import 'package:todo_app/logic/models/quick_note.dart';
import 'package:todo_app/logic/models/radio_color.dart';
import 'package:todo_app/logic/providers/firebase_data.dart';
import 'package:todo_app/logic/repositories/quick_note_repository.dart';
import 'package:todo_app/views/utils/extension/snack_bar.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'color_picker.dart';
import 'desc_box_note.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({Key? key}) : super(key: key);

  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(249, 96, 96, 1),
          elevation: 0,
          title: Text('Add Note', style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),
        body: Container(
          child: NewNoteForm(),
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

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({Key? key}) : super(key: key);

  @override
  _NewNoteFormState createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RadioColorList>(
      create: (_) => RadioColorList.autoInitial(),
      child: Padding(
          padding: EdgeInsets.only(
              top: 10.h,
              left: 16.w,
              right: 16.w,
              bottom: MediaQuery.of(context).size.height - 500.h),
          child: Consumer<RadioColorList>(builder: (context, color, child) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  DescriptionNotePanel(
                    textController: _titleController,
                  ),
                  SizedBox(height: 20.h),
                  ColorPicker(),
                  SizedBox(height: 30.h),
                  StrechButton(
                    text: 'Done',
                    onPressed: () {
                      if (_titleController.text.isNotEmpty) {
                        FirebaseQuickNoteRepository _quickNoteRepository =
                            FirebaseQuickNoteRepository();
                        _quickNoteRepository.addQuickNote(QuickNoteModel(
                          checkList: [],
                          id: 'this field is unneccessary for firebase',
                          title: _titleController.text,
                          color: color.getSelectColor(),
                          userId: FirebaseDataProvider.uid,
                        ));
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            ExpandedSnackBar.failureSnackBar(
                                context, ErrorInCreate.emptyDescNote));
                      }
                    },
                    buttonStyle: AppButtonDecoration.authenticate2,
                    horizontalPadding: 25.w,
                  ),
                ],
              ),
            );
          })),
    );
  }
}
