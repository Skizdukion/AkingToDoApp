import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/models/user.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class ProjectSelectedSuggestCard extends StatefulWidget {
  const ProjectSelectedSuggestCard({ Key? key, required this.onTap, required this.item}) : super(key: key);
  final ProjectModel item;
  final VoidCallback onTap;

  @override
  _ProjectSelectedSuggestCardState createState() => _ProjectSelectedSuggestCardState();
}

class _ProjectSelectedSuggestCardState extends State<ProjectSelectedSuggestCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Container(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 10,),
                Text("${widget.item.title}", style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold, fontSize: 14),),
              ],
            ),
          ),
          onTap: widget.onTap,
        ),
        height: 48,
      ),
      elevation: 0.0,
      color: Color.fromRGBO(244, 244, 244, 1),
    );
  }
}

class UserSelectedSuggestCard extends StatefulWidget {
  const UserSelectedSuggestCard({ Key? key, required this.onTap, required this.item}) : super(key: key);
  final UserModel item;
  final VoidCallback onTap;

  @override
  _UserSelectedSuggestCardState createState() => _UserSelectedSuggestCardState();
}

class _UserSelectedSuggestCardState extends State<UserSelectedSuggestCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Container(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20, 
                  backgroundImage: NetworkImage('${widget.item.imgUrl}'),                     
                ),
                const SizedBox(width: 10,),
                Text("${widget.item.name}", style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold, fontSize: 14),),
              ],
            ),
          ),
          onTap: widget.onTap,
        ),
        height: 48,
      ),
      elevation: 0.0,
      color: Color.fromRGBO(244, 244, 244, 1),
    );
  }
}