import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_app/models/repositories/models/statictis.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class StatictisPanel extends StatefulWidget {
  const StatictisPanel({ Key? key }) : super(key: key);

  @override
  _StatictisPanelState createState() => _StatictisPanelState();
}

class _StatictisPanelState extends State<StatictisPanel> {

  late List<TasksStatictis> _taskStatictis;

  @override
  void initState() {
    _taskStatictis = [
      TasksStatictis(totalTask: 12, doneTask: 7, color: Color.fromRGBO(249, 96, 96, 1), type: 'Events'),
      TasksStatictis(totalTask: 20, doneTask: 3, color: Color.fromRGBO(96, 116, 249, 1), type: 'To do'),
      TasksStatictis(totalTask: 12, doneTask: 5, color: Color.fromRGBO(133, 96, 249, 1), type: 'Quick Notes'),
    ];
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Statistic', style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Row(
                children: [
                  for (var item in _taskStatictis) StatictisItem(item: item)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatictisItem extends StatelessWidget {
  const StatictisItem({ Key? key, required this.item}) : super(key: key);
  final TasksStatictis item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 2.0,
            percent: item.doneTask/item.totalTask,
            center: Text('${(item.doneTask/item.totalTask*100).toInt()}%', style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold),),
            progressColor: item.color,
          ),
          SizedBox(height: 15,),
          Text('${item.type}', style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 32,),
        ],
      ),
    );
  }
}