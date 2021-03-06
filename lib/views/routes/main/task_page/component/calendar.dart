import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/blocs/task/task_bloc.dart';
import 'package:todo_app/logic/blocs/task/task_state.dart';
import 'package:todo_app/logic/models/task.dart';
import 'package:todo_app/logic/repositories/task_repository.dart';
import 'package:todo_app/views/routes/main/task_page/component/slidable_task_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TaskCalendar extends StatefulWidget {
  const TaskCalendar({Key? key, required this.data}) : super(key: key);
  final List<TaskModel> data;

  @override
  _TaskCalendarState createState() => _TaskCalendarState();
}

class _TaskCalendarState extends State<TaskCalendar> {
  DateTime? _selectedDay;

  late Stream<List<TaskModel>> _selectedTasks;
  DateTime _rangeStart = DateTime.utc(2010, 10, 16);
  DateTime _rangeEnd = DateTime.utc(2030, 3, 14);
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  List<TaskModel> getTaskListFromDate(DateTime date) {
    List<TaskModel> returnList = [];
    widget.data.forEach((val) {
      if ((val.dueDate!.day == date.day) &&
          (val.dueDate!.month == date.month) &&
          (val.dueDate!.year == date.year)) {
        returnList.add(val);
      }
    });
    return returnList;
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedTasks =
        FirebaseTaskRepository().getStreamTaskListForDay(_selectedDay!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        _selectedTasks =
            state.firebaseTaskRepository.getStreamTaskListForDay(_selectedDay!);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            firstDay: _rangeStart,
            lastDay: _rangeEnd,
            focusedDay: _focusedDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _focusedDay = focusedDay;
                  _selectedDay = selectedDay;
                  _selectedTasks = FirebaseTaskRepository()
                      .getStreamTaskListForDay(_selectedDay!);
                });
              }
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) => getTaskListFromDate(day),
            calendarStyle: CalendarStyle(
              markersMaxCount: 1,
              markerDecoration: BoxDecoration(
                color: Color.fromRGBO(249, 96, 96, 1),
                shape: BoxShape.circle,
              ),
              markerSizeScale: 0.1,
              selectedDecoration: BoxDecoration(
                color: Color.fromRGBO(100, 150, 150, 1),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.white10,
                shape: BoxShape.circle,
                border: Border.all(color: Color.fromRGBO(100, 150, 150, 1)),
              ),
              todayTextStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            headerStyle: HeaderStyle(
              headerMargin: EdgeInsets.all(10.0),
              headerPadding: const EdgeInsets.symmetric(vertical: 0.0),
              titleCentered: true,
              leftChevronVisible: false,
              rightChevronVisible: false,
              formatButtonVisible: false,
            ),
            availableCalendarFormats: const {
              CalendarFormat.month: 'month',
              CalendarFormat.week: 'week',
            },
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) =>
                  DateFormat.E(locale).format(date)[0],
              weekdayStyle: const TextStyle(
                  color: const Color.fromRGBO(154, 154, 154, 1)),
              weekendStyle: const TextStyle(
                  color: const Color.fromRGBO(154, 154, 154, 1)),
            ),
          ),
          SizedBox(height: 8.0.h),
          Text(DateFormat('E, MMM d/yyyy').format(_selectedDay!).toUpperCase(),
              style: AppTextDecoration.light154W400S14),
          SizedBox(height: 8.0.h),
          Expanded(
            child: StreamBuilder<List<TaskModel>>(
                stream: _selectedTasks,
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
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        task: data[index],
                        key: Key(data[index].taskId),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }

  // void deleteTask(String id){
  //   _taskRepository.deleteTask(id);
  //   _selectedTasks.value = _taskRepository.getTaskListForDay('userID', _selectedDay!);
  //   setState(() {

  //   });
  // }
}
