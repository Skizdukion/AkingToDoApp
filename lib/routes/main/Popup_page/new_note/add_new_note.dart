import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/repositories/models/radio_color.dart';
import 'package:todo_app/routes/main/Popup_page/new_note/color_picker.dart';
import 'package:todo_app/widgets/const_decoration.dart';

import 'desc_box_note.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({ Key? key }) : super(key: key);

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
  const NewNoteForm({ Key? key }) : super(key: key);

  @override
  _NewNoteFormState createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RadioColorList>(
      create: (_) => RadioColorList.autoInitial(),
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 230),
        child: Container(
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
              SizedBox(height: 20),
              DescriptionNoteBox(),
              SizedBox(height: 20),
              ColorPicker(),
              SizedBox(height: 30),
              DoneBtn(),
            ],
          ),
        )
      ),
    );
  }
}

class DoneBtn extends StatelessWidget {
  const DoneBtn({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: (){
            print(Provider.of<RadioColorList>(context, listen: false).getSelectColor());
          },
          style: buttonStyleAuthPages,
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}