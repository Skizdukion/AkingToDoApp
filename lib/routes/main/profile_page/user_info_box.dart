import 'package:flutter/material.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class UserInfoBox extends StatefulWidget {
  const UserInfoBox({ Key? key }) : super(key: key);

  @override
  _UserInfoBoxState createState() => _UserInfoBoxState();
}

class _UserInfoBoxState extends State<UserInfoBox> {
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
                        backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTv7Qrvj5xHRuCCDSoqi9U-IqESntWh4bMG5w&usqp=CAU'),                     
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Long Pham", style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold),),
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
}



