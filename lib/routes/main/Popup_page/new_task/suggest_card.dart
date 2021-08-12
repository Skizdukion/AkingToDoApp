import 'package:flutter/material.dart';
import 'package:todo_app/widgets/const_decoration.dart';


class SelectSuggestCard extends StatefulWidget {
  const SelectSuggestCard({ Key? key, required this.initText, required this.onTap, required this.onChange }) : super(key: key);
  final initText;
  final VoidCallback onTap;
  final ValueSetter<String> onChange;

  @override
  _SelectSuggestCardState createState() => _SelectSuggestCardState();
}

class _SelectSuggestCardState extends State<SelectSuggestCard> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: TextFormField(
              style: textDarkStyleW400S16.copyWith(fontSize: 18),
              autofocus: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: '  ${widget.initText}',
                hintStyle: textDarkStyleW400S16.copyWith(fontSize: 14),
              ),
              onTap: (){
                widget.onTap();
              },
              onChanged: (val){
                widget.onChange(val);
              },
            ),
          ),
        ),
        width: 90,
        height: 48,
      ),
      elevation: 0.0,
      color: Color.fromRGBO(244, 244, 244, 1),
    );
  }
}