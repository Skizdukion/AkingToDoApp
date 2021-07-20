import 'package:flutter/material.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class DescriptionNoteBox extends StatefulWidget {
  const DescriptionNoteBox({ Key? key }) : super(key: key);

  @override
  _DescriptionNoteBoxState createState() => _DescriptionNoteBoxState();
}

class _DescriptionNoteBoxState extends State<DescriptionNoteBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Description',style: textDarkStyleS18,),
          SizedBox(height: 10,),
          Container(
            width: 310,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: TextField(
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}