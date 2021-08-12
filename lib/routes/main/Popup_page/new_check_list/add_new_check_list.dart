import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/repositories/models/check.dart';
import 'package:todo_app/models/repositories/models/radio_color.dart';
import 'package:todo_app/routes/main/popup_page/new_check_list/title_box_check_list.dart';
import 'package:todo_app/routes/main/popup_page/new_note/color_picker.dart';
import 'package:todo_app/widgets/const_decoration.dart';

import 'check_list.dart';


class NewCheckListPage extends StatefulWidget {
  const NewCheckListPage({ Key? key }) : super(key: key);

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
  const NewCheckListForm({ Key? key }) : super(key: key);

  @override
  _NewCheckListFormState createState() => _NewCheckListFormState();
}

class _NewCheckListFormState extends State<NewCheckListForm> {


  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
      providers: [
        ChangeNotifierProvider<CheckListModel>(create: (_) => CheckListModel.fakeData()),
        ChangeNotifierProvider<RadioColorList>(create: (_) => RadioColorList.autoInitial()),
      ],
      child: Consumer2<CheckListModel,RadioColorList>(
        builder: (context, checkList, color, child){
          return Padding(
            padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: (MediaQuery.of(context).size.height - 450 - checkList.checkList.length*50)),
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
                  TilteBoxCheckList(),
                  SizedBox(height: 20,),
                  ColorPicker(),
                  SizedBox(height: 20,),
                  CheckList(),
                  Center(
                    child: TextButton(
                      onPressed: (){
                        checkList.addAutoCheckNote();
                      },
                      child: Text('+ Add new item', style: textDarkStyleS18.copyWith(fontSize: 16),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: (){
                          print(checkList.checkList.length);
                          print(color.getSelectColor());
                        },
                        style: buttonStyleAuthPages,
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          );
        }
      ),
    );
  }
}
