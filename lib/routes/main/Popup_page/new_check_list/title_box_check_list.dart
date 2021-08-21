import 'package:flutter/material.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class TilteBoxCheckList extends StatefulWidget {
  const TilteBoxCheckList({ Key? key, required this.titleController }) : super(key: key);
  final TextEditingController titleController;
  @override
  _TilteBoxCheckListState createState() => _TilteBoxCheckListState();
}

class _TilteBoxCheckListState extends State<TilteBoxCheckList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Title',style: textDarkStyleS18,),
          SizedBox(height: 10,),
          Container(
            width: 310,
            height: 40,
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
                      textInputAction: TextInputAction.done,
                      controller: widget.titleController,
                      style: textDarkStyleS18,
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