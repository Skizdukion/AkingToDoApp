import 'dart:ui';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_event.dart';
import 'package:todo_app/logic/repositories/user_repository.dart';
import 'package:todo_app/views/widgets/image_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoPanel extends StatefulWidget {
  const UserInfoPanel(
      {Key? key,
      required this.userUrlImg,
      required this.userEmail,
      required this.userName,
      this.userTotalDoneTask = '...',
      this.userTotalTask = '...'})
      : super(key: key);
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
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        child: Material(
          elevation: 2.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: EdgeInsets.only(left: 25.w),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: ImgLoading(
                      radius: 32.h,
                      imgUrl: widget.userUrlImg,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h, left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style: AppTextDecoration.darkS18
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.userEmail,
                            style: AppTextDecoration.light154W400S14
                                .copyWith(fontSize: 16),
                          ),
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
                      if (value == 2) {
                        authBloc.add(Logout());
                      }
                      if (value == 0) {
                        _showChangeNameDialog();
                      }
                      if (value == 1) {
                        _showChangeImgUrlDialog();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    offset: Offset(-10, 40),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.userTotalTask,
                          style: AppTextDecoration.darkS18
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text('Created Tasks',
                          style: AppTextDecoration.light154W400S14
                              .copyWith(fontSize: 16)),
                    ],
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.userTotalDoneTask,
                          style: AppTextDecoration.darkS18
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text('Completed Tasks',
                          style: AppTextDecoration.light154W400S14
                              .copyWith(fontSize: 16)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  _showChangeNameDialog() async {
    final text = await showTextInputDialog(
        context: context,
        title: 'Change your name',
        textFields: [
          DialogTextField(hintText: 'User name', initialText: widget.userName),
        ]);
    if (text != null) {
      if ((text.first != widget.userName) && (text.first.isNotEmpty))
        await FirebaseUserRepository().changeCurrentUserName(text.first);
    }
  }

  _showChangeImgUrlDialog() async {
    final text = await showTextInputDialog(
        context: context,
        title: 'Change your avatar',
        textFields: [
          DialogTextField(
              hintText: 'Image Url', initialText: widget.userUrlImg),
        ]);
    if (text != null) {
      if ((text.first != widget.userUrlImg) && (text.first.isNotEmpty))
        await FirebaseUserRepository().changeCurrentUserImgUrl(text.first);
    }
  }
}
