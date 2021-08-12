import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/user.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class AsigneeSuggestPanel extends StatefulWidget {
  const AsigneeSuggestPanel({ Key? key, required this.userList, required this.onSelectUser}) : super(key: key);
  final List<UserModel> userList;
  final ValueSetter<String> onSelectUser;

  @override
  _AsigneeSuggestPanelState createState() => _AsigneeSuggestPanelState();
}

class _AsigneeSuggestPanelState extends State<AsigneeSuggestPanel> {

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 244, 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListView.builder(
          itemCount: widget.userList.length,
          itemBuilder: (context, index){
            return AsigneeUserSuggestion(item: widget.userList[index], onSelectedUser: widget.onSelectUser,);
          },
        ),
      )
    );
  }
}

class AsigneeUserSuggestion extends StatefulWidget {
  const AsigneeUserSuggestion({ Key? key, required this.item, required this.onSelectedUser}) : super(key: key);
  final UserModel item;
  final ValueSetter<String> onSelectedUser;

  @override
  _AsigneeUserSuggestionState createState() => _AsigneeUserSuggestionState();
}

class _AsigneeUserSuggestionState extends State<AsigneeUserSuggestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, bottom:10),
      child: InkWell(
        child: Container(
          child: Row(
            children: [
              CircleAvatar(
                radius: 20, 
                backgroundImage: NetworkImage('${widget.item.imgUrl}'),                     
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.item.name}", style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold, fontSize: 16),),
                  Text('${widget.item.email}', style: textLight154StyleW400S14,),
                ],
              )
            ],
          ),
        ),
        onTap: () => widget.onSelectedUser(widget.item.id),
      ),
    );
  }
}