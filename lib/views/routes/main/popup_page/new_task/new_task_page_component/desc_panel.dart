import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';

class DescriptionPanel extends StatefulWidget {
  const DescriptionPanel({Key? key, required this.descriptionController})
      : super(key: key);
  final TextEditingController descriptionController;

  @override
  _DescriptionPanelState createState() => _DescriptionPanelState();
}

class _DescriptionPanelState extends State<DescriptionPanel> {
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
            style: AppTextDecoration.light158S16,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 250,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Color.fromRGBO(234, 234, 234, 1)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 62,
                  child: Center(
                    child: TextFormField(
                      style: AppTextDecoration.darkS18,
                      minLines: 3,
                      maxLines: 3,
                      controller: widget.descriptionController,
                    ),
                  ),
                ),
                Expanded(
                  flex: 38,
                  child: Container(
                    color: Color.fromRGBO(234, 234, 234, 1),
                    child: IconButton(
                      icon: Icon(Icons.attachment_outlined),
                      onPressed: () {},
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
