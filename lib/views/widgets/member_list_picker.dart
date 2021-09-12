import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_state.dart';
import 'package:todo_app/logic/models/user.dart';
import 'package:todo_app/logic/repositories/user_repository.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';

import 'image_loading.dart';

class MemberListPicker extends StatefulWidget {
  const MemberListPicker({Key? key, required this.memberList})
      : super(key: key);
  final List<String> memberList;

  @override
  _MemberListPickerState createState() => _MemberListPickerState();
}

class _MemberListPickerState extends State<MemberListPicker> {
  ValueNotifier<String> searchString = ValueNotifier('');
  late Stream<List<UserModel>> userStreamList;
  late Future<List<UserModel>> memberFutureList;
  TextEditingController _textEditingController = TextEditingController();
  late AuthState authState;
  List<UserModel> memberList = [];

  @override
  void initState() {
    memberFutureList = FirebaseUserRepository()
        .convertListStringToListUserModel(widget.memberList);
    authState = BlocProvider.of<AuthBloc>(context).state;
    if (authState is LoggeddUser) {
      userStreamList =
          (authState as LoggeddUser).firebaseDataProvider.cache.allUserList;
    } else {
      throw ("access denied ${authState.toString()}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
        future: memberFutureList,
        builder: (context, memberListSnapshot) {
          return Container(
            height: 400,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: TextFormField(
                    controller: _textEditingController,
                    style: AppTextDecoration.darkW400S16.copyWith(fontSize: 18),
                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'User name',
                    ),
                    onChanged: (val) {
                      searchString.value = val;
                    },
                  ),
                ),
                Container(
                    height: 280,
                    child: StreamBuilder<List<UserModel>>(
                        stream: userStreamList,
                        builder: (context, userListSnapshot) {
                          if (userListSnapshot.hasError ||
                              memberListSnapshot.hasError) {
                            return Center(
                              child: Text('Error'),
                            );
                          }
                          if (!userListSnapshot.hasData ||
                              !memberListSnapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          memberList = memberListSnapshot.data!;
                          return ValueListenableBuilder<String>(
                            valueListenable: searchString,
                            builder: (context, value, _) {
                              List<UserModel> userList =
                                  FirebaseUserRepository()
                                      .getUserListContainString(
                                          searchString.value,
                                          userListSnapshot.data!);
                              return ListView.builder(
                                itemCount: userList.length,
                                itemBuilder: (context, index) {
                                  return UserItemInAddMember(
                                    item: userList[index],
                                    addMember: addMemberToList,
                                    unAddmember: unAddMemberToList,
                                    isSelected:
                                        checkSelected(userList[index].id),
                                  );
                                },
                              );
                            },
                          );
                        })),
                SizedBox(
                  height: 10,
                ),
                StrechButton(
                  text: 'Done',
                  onPressed: () {
                    Navigator.pop(context, memberList);
                  },
                  buttonStyle: AppButtonDecoration.authenticate2,
                  horizontalPadding: 80,
                ),
              ],
            ),
          );
        });
  }

  bool checkSelected(String id) {
    bool returnBool = false;
    for (var item in memberList) {
      if (item.id == id) {
        returnBool = true;
        break;
      }
    }
    return returnBool;
  }

  void addMemberToList(UserModel item) {
    memberList.add(item);
  }

  void unAddMemberToList(UserModel item) {
    UserModel? removeMember;
    for (var member in memberList) {
      if (member.id == item.id) removeMember = member;
    }
    memberList.remove(removeMember);
  }
}

class UserItemInAddMember extends StatefulWidget {
  const UserItemInAddMember(
      {Key? key,
      required this.item,
      required this.addMember,
      required this.unAddmember,
      this.isSelected = false})
      : super(key: key);
  final UserModel item;
  final ValueSetter<UserModel> addMember;
  final ValueSetter<UserModel> unAddmember;
  final bool isSelected;
  @override
  _UserItemInAddMemberState createState() => _UserItemInAddMemberState();
}

class _UserItemInAddMemberState extends State<UserItemInAddMember> {
  late bool isAdd;

  @override
  void initState() {
    isAdd = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        child: Row(
          children: [
            ImgLoading(imgUrl: widget.item.imgUrl, radius: 20),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.item.name}",
                  style: AppTextDecoration.darkS18
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '${widget.item.email}',
                  style: AppTextDecoration.light154W400S14,
                ),
              ],
            ),
            Spacer(),
            Checkbox(
              checkColor: Colors.white,
              value: isAdd,
              onChanged: (bool? val) {
                setState(() {
                  isAdd = val!;
                });
                if (val == true) {
                  widget.addMember(widget.item);
                } else
                  widget.unAddmember(widget.item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
