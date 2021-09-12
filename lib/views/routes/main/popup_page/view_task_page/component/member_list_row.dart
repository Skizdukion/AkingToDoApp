import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/models/user.dart';
import 'package:todo_app/logic/repositories/user_repository.dart';
import 'package:todo_app/views/widgets/image_loading.dart';

import 'component_template.dart';

class MemberListRow extends StatelessWidget {
  const MemberListRow({Key? key, required this.memberList}) : super(key: key);
  final List<String> memberList;

  @override
  Widget build(BuildContext context) {
    int listLen;
    if (memberList.length > 9) {
      listLen = 9;
    } else
      listLen = memberList.length;
    return ComponentTemplate(child: [
      SizedBox(width: 10),
      Icon(
        Icons.person_outline,
        size: 15,
      ),
      SizedBox(
        width: 25,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Member",
            style: AppTextDecoration.light154W400S14
                .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              for (var i = 0; i < listLen; i++)
                MemberAvatarItem(userId: memberList[i]),
              if (memberList.length > 9)
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://image.shutterstock.com/image-vector/vector-ellipses-icon-triple-dots-260nw-709829182.jpg'),
                )
            ],
          ),
          if (memberList.length == 0)
            SizedBox(
              height: 30,
            ),
        ],
      ),
    ]);
  }
}

class MemberAvatarItem extends StatefulWidget {
  const MemberAvatarItem({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  _MemberAvatarItemState createState() => _MemberAvatarItemState();
}

class _MemberAvatarItemState extends State<MemberAvatarItem> {
  @override
  Widget build(BuildContext context) {
    Stream<UserModel> userStream =
        FirebaseUserRepository().getStreamUserWithId(widget.userId);
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: StreamBuilder<UserModel>(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Failed'),
              );
            }
            if (!snapshot.hasData) {
              return const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blue,
              );
            }
            UserModel user = snapshot.data!;
            return ImgLoading(imgUrl: user.imgUrl, radius: 16);
          }),
    );
  }
}
