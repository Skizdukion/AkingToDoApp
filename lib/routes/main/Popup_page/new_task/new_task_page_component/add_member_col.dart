import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/models/blocs/new_task/new_task_event.dart';
import 'package:todo_app/models/blocs/new_task/new_task_state.dart';
import 'package:todo_app/models/repositories/models/user.dart';
import 'package:todo_app/models/repositories/user_repository.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class AddMemberCol extends StatefulWidget {
  const AddMemberCol({ Key? key }) : super(key: key);

  @override
  _AddMemberColState createState() => _AddMemberColState();
}

class _AddMemberColState extends State<AddMemberCol> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskBloc, NewTaskState>(
      builder: (context, state){
        return Padding(
          padding: EdgeInsets.only(left: 24),
          child: Column(
            children: [
              Text('Add Member', style: textDarkStyleW400S16,),
              SizedBox(height: 8),
              if (state.memberList.length == 0) SizedBox(
                height: 50,
                width: 90,
                child: TextButton(
                  child: Text('Anyone', style: textDarkStyleW400S16.copyWith(fontSize: 14),),
                  onPressed: (){
                    _showAddMenu();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(244, 244, 244, 1)),
                  ),
                ),
              ),
              if (state.memberList.length != 0) Row(
                children: [
                  for (var item in state.memberList) Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 16, 
                      backgroundImage: NetworkImage('${item.imgUrl}'),                     
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(204, 204, 204, 1),
                    ),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: (){
                        _showAddMenu();
                      }, 
                      icon: Icon(
                        Icons.edit,
                        size: 16,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }
    );
  }

  _showAddMenu() async {
    List<UserModel>? memberList = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: UserPicker(),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
          )
        );
      }
    );
    if (memberList != null) context.read<NewTaskBloc>().add(MemberListOnChange(memberList: memberList));
  }
}

class UserPicker extends StatefulWidget {
  const UserPicker({ Key? key }) : super(key: key);

  @override
  _UserPickerState createState() => _UserPickerState();
}

class _UserPickerState extends State<UserPicker> {

  // ValueNotifier<List<UserModel>> userList = ValueNotifier([]..addAll(FakeUserRepository().getUserList()));
  ValueNotifier<String> searchString = ValueNotifier('');
  Stream<List<UserModel>> streamUserList = FirebaseUserRepository().getStreamUserList();
  List<UserModel> memberList = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          SizedBox(height: 5,),
          Center(
            child: TextFormField(
              controller: _textEditingController,
              style: textDarkStyleW400S16.copyWith(fontSize: 18),
              autofocus: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'User name',
              ),
              onChanged: (val){
                searchString.value = val;
              },
            ),
          ),
          Container(
            height: 280,
            child: StreamBuilder<List<UserModel>>(
              stream: streamUserList,
              builder: (context, userListSnapshot) {
                if (userListSnapshot.hasError) {
                  return Center(
                    child: Text('Error'),
                  );
                }
                if (!userListSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ValueListenableBuilder<String>(
                  valueListenable: searchString,
                  builder: (context, value, _){
                    List<UserModel> userList = FirebaseUserRepository().getUserListContainString(searchString.value, userListSnapshot.data!);
                    return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index){
                        return UserItemInAddMember(item: userList[index], addMember: addMemberToList, unAddmember: unAddMemberToList,);
                      },
                    );
                  },
                );
              }
            )
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, memberList);
                },
                style: buttonStyleAuthPages,
                child: Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addMemberToList(UserModel item){
    memberList.add(item);
  }

  void unAddMemberToList(UserModel item){
    memberList.remove(item);
  }
}



class UserItemInAddMember extends StatefulWidget {
  const UserItemInAddMember({ Key? key, required this.item, required this.addMember, required this.unAddmember }) : super(key: key);
  final UserModel item;
  final ValueSetter<UserModel> addMember;
  final ValueSetter<UserModel> unAddmember;
  @override
  _UserItemInAddMemberState createState() => _UserItemInAddMemberState();
}

class _UserItemInAddMemberState extends State<UserItemInAddMember> {

  late bool isAdd;

  @override
  void initState() {
    isAdd = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            ),
            Spacer(),
            Checkbox(
              checkColor: Colors.white,
              value: isAdd,
              onChanged: (bool? val) {  
                setState(() {
                  isAdd = val!;
                });
                if(val == true){
                  widget.addMember(widget.item);
                }
                else widget.unAddmember(widget.item);
              },
            ),
          ],
        ),
      ),
    );
  }
}


