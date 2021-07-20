import 'package:flutter/material.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class AddMemberCol extends StatefulWidget {
  const AddMemberCol({ Key? key }) : super(key: key);

  @override
  _AddMemberColState createState() => _AddMemberColState();
}

class _AddMemberColState extends State<AddMemberCol> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24),
      child: Column(
        children: [
          Text('Add Member', style: textDarkStyleW400S16,),
          SizedBox(height: 8),
          SizedBox(
            height: 50,
            width: 90,
            child: TextButton(
              child: Text('Anyone', style: textDarkStyleW400S16.copyWith(fontSize: 14),),
              onPressed: (){},
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(244, 244, 244, 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}