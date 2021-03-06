import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/models/statictis.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class StatictisPanel extends StatefulWidget {
  const StatictisPanel({Key? key, required this.taskStatictis})
      : super(key: key);
  final List<TasksStatictis> taskStatictis;

  @override
  _StatictisPanelState createState() => _StatictisPanelState();
}

class _StatictisPanelState extends State<StatictisPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 25.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, top: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statistic',
                style: AppTextDecoration.darkS18
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  for (var item in widget.taskStatictis)
                    StatictisItem(item: item)
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
  const StatictisItem({Key? key, required this.item}) : super(key: key);
  final TasksStatictis item;

  @override
  Widget build(BuildContext context) {
    double percent =
        ((item.totalTask != 0) ? item.doneTask / item.totalTask : 0).toDouble();
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 100.r,
            lineWidth: 2.0,
            percent: percent,
            center: Text(
              '${(percent * 100).toInt()}%',
              style: AppTextDecoration.darkS18
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            progressColor: item.color,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text('${item.type}',
              style: AppTextDecoration.darkS18
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(
            height: 32.h,
          ),
        ],
      ),
    );
  }
}
