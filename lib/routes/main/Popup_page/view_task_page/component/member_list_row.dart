import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/user.dart';
import 'package:todo_app/models/repositories/user_repository.dart';
import 'package:todo_app/routes/main/popup_page/view_task_page/component/component_template.dart';
import 'package:todo_app/widgets/const_decoration.dart';


class MemberListRow extends StatelessWidget {
  const MemberListRow({ Key? key, required this.memberList }) : super(key: key);
  final List<String> memberList;

  @override
  Widget build(BuildContext context) {
    return ComponentTemplate(child: [
      SizedBox(width: 10),
      Icon(
        Icons.person_outline,
        size: 15,
      ),
      SizedBox(width: 25,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Member", style: textLight154StyleW400S14.copyWith(fontWeight: FontWeight.bold, fontSize: 16),),
          SizedBox(height: 5),
          Row(
            children: [
              for (var member in memberList) MemberAvatarItem(userId: member),
            ],
          ),
          if (memberList.length == 0) SizedBox(height: 30,),
        ],
      ),
    ]);
  }
}

class MemberAvatarItem extends StatelessWidget {
  const MemberAvatarItem({ Key? key, required this.userId }) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    UserModel user = FakeUserRepository().getUserWithId(userId)!;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CircleAvatar(
        radius: 16, 
        backgroundImage: NetworkImage('${user.imgUrl}'),                     
      ),
    );
  }
}