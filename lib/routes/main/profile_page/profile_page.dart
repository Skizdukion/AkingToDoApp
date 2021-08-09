import 'package:flutter/material.dart';
import 'package:todo_app/routes/main/profile_page/statistic_panel.dart';
import 'package:todo_app/routes/main/profile_page/user_info_box.dart';
import 'task_in_category.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0, 
          title: Text('Profiles', style: TextStyle(fontSize: 20, color: Colors.black)),
          centerTitle: true,
        ),
        body: ProfileBody(),
      ),
    );
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({ Key? key }) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          SizedBox(height: 25,),
          UserInfoBox(),
          SizedBox(height: 40,),
          TasksInCategory(),
          StatictisPanel(),
        ],
      ),
    );
  }
}
