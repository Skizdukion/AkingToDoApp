import 'package:flutter/material.dart';
import 'package:todo_app/widgets/const_decoration.dart';


class SelectSuggestCard extends StatefulWidget {
  const SelectSuggestCard({ Key? key, required this.initText }) : super(key: key);
  final initText;

  @override
  _SelectSuggestCardState createState() => _SelectSuggestCardState();
}

class _SelectSuggestCardState extends State<SelectSuggestCard> {
  String displayText = '';
  @override
  void initState() {
    displayText = widget.initText;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Container(
          child: Center(child: Text(displayText, style: textDarkStyleW400S16.copyWith(fontSize: 14),)),
          width: 90,
          height: 48,
        ),
        elevation: 0.0,
        color: Color.fromRGBO(244, 244, 244, 1),
      ),
      onTap: (){
        setState(() {
          displayText = '|';
        });
      },
    );
  }
}