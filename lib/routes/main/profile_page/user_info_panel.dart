import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_state.dart';
import 'package:todo_app/models/repositories/models/task.dart';
import 'package:todo_app/models/repositories/models/user.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class UserInfoPanel extends StatefulWidget {
  const UserInfoPanel({ Key? key }) : super(key: key);

  @override
  _UserInfoPanelState createState() => _UserInfoPanelState();
}

class _UserInfoPanelState extends State<UserInfoPanel> {

  late Stream<UserModel> user;
  late Stream<List<TaskModel>> taskList;

  @override
  void initState() {
    AuthState authState = BlocProvider.of<AuthBloc>(context).state;
    if(authState is LoginedUser){
      user = authState.user.getUserData();
      taskList = authState.user.getTaskList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: user,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.requireData;
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
                            backgroundImage: NetworkImage(data.imgUrl),                     
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${data.name}", style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold),),
                                Text('rider993sinus@gmail.com', style: textLight154StyleW400S14.copyWith(fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: (){},
                          iconSize: 15,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('120', style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold)),
                            Text('Created Tasks', style: textLight154StyleW400S14.copyWith(fontSize: 16)),
                          ],
                        ),
                        SizedBox(width: 50,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('80', style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold)),
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
    );
  }
}



