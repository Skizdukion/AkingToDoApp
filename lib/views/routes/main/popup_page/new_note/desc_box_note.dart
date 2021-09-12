import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';

class DescriptionNotePanel extends StatefulWidget {
  const DescriptionNotePanel({Key? key, required this.textController})
      : super(key: key);
  final TextEditingController textController;

  @override
  _DescriptionNotePanelState createState() => _DescriptionNotePanelState();
}

class _DescriptionNotePanelState extends State<DescriptionNotePanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Description',
            style: AppTextDecoration.darkS18,
          ),
          SizedBox(
            height: 10,
          ),
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
                    child: TextFormField(
                      controller: widget.textController,
                      style: AppTextDecoration.darkS18,
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
