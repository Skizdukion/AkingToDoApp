import 'package:flutter/material.dart';

class ComponentTemplate extends StatelessWidget {
  const ComponentTemplate({ Key? key, required this.child}) : super(key: key);
  final List<Widget> child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            children: [
              for (var item in child) item,
            ],
          ),
          SizedBox(height: 5,),
          Divider(
            
          ),
        ],
      )
    );
  }
}