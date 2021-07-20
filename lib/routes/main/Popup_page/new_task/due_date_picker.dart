import 'package:flutter/material.dart';
import 'package:todo_app/widgets/const_decoration.dart';


class DueDatePicker extends StatefulWidget {
  const DueDatePicker({ Key? key }) : super(key: key);

  @override
  _DueDatePickerState createState() => _DueDatePickerState();
}

class _DueDatePickerState extends State<DueDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 244, 244, 1),
      ),
      child: Row(
        children: [
          SizedBox(width: 25,),
          Text('Due Date', style: textDarkStyleW400S16,),
          SizedBox(width: 10,),
          TextButton(
            child: Text('Anytime',style: TextStyle(color: Colors.white, fontSize: 14),),
            onPressed: (){
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(96, 116, 249, 1)),
            ),
          ),
        ],
      ),
    );
  }
}