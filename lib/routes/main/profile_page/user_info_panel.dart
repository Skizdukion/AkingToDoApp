import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_event.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class UserInfoPanel extends StatefulWidget {
  const UserInfoPanel({ Key? key, required this.userUrlImg, required this.userEmail, required this.userName, this.userTotalDoneTask = '...', this.userTotalTask = '...' }) : super(key: key);
  final String userName;
  final String userUrlImg;
  final String userEmail;
  final String userTotalTask;
  final String userTotalDoneTask;

  @override
  _UserInfoPanelState createState() => _UserInfoPanelState();
}

class _UserInfoPanelState extends State<UserInfoPanel> {

  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        child: Material(
          elevation: 2.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: CircleAvatar(
                        radius: 32, 
                        backgroundImage: NetworkImage(widget.userUrlImg),                     
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.userName, style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold),),
                            Text(widget.userEmail, style: textLight154StyleW400S14.copyWith(fontSize: 16),),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          child: Text('Change Name'),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text('Change Image Url'),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text('Log Out'),
                          value: 2,
                        ),
                      ],
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      iconSize: 15,
                      onSelected: (int value) {
                        if(value == 2){
                          authBloc.add(Logout());
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      offset: Offset(-10, 40),
                    )
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.userTotalTask, style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold)),
                        Text('Created Tasks', style: textLight154StyleW400S14.copyWith(fontSize: 16)),
                      ],
                    ),
                    SizedBox(width: 50,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.userTotalDoneTask, style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold)),
                        Text('Completed Tasks', style: textLight154StyleW400S14.copyWith(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
              ]
            ),
          ),
        ),
      ),
    );
  }
}



