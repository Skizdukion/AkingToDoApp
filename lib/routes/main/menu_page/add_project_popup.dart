import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/repositories/models/radio_color.dart';
import 'package:todo_app/routes/main/Popup_page/new_note/color_picker.dart';
import 'package:todo_app/widgets/const_decoration.dart';

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
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: buttonStyleAuthPages,
                  onPressed: (){},
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
      ),
    );
  }
}
