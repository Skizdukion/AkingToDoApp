import 'package:flutter/material.dart';
import 'package:todo_app/routes/main/Popup_page/new_task/add_member_col.dart';
import 'package:todo_app/widgets/const_decoration.dart';

import 'desc_box.dart';
import 'due_date_picker.dart';
import 'for_in_row.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({ Key? key }) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(249, 96, 96, 1),
          elevation: 0, 
          title: Text('New Task', style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),
        body: Container(
          child: NewTaskForm(),
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

class NewTaskForm extends StatefulWidget {
  const NewTaskForm({ Key? key }) : super(key: key);

  @override
  _NewTaskFormState createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 30),
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
            SizedBox(height: 20),
            ForInRow(),
            SizedBox(height: 20),
            Container(
              child: Center(
                child: TextField(
                  style: textDarkStyleS18,
                  decoration: new InputDecoration.collapsed(
                    hintText: 'Title',
                    hintStyle: textDarkStyleS18,
                  ),
                ),
              ),
              color: Color.fromRGBO(244, 244, 244, 1),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: 60,
            ),
            SizedBox(height: 20),
            DescriptionBox(),
            SizedBox(height: 20),
            DueDatePicker(),
            SizedBox(height: 20),
            AddMemberCol(),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: (){},
                  style: buttonStyleAuthPages,
                  child: Text(
                    "Add Task",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
