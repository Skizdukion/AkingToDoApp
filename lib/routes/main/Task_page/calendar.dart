import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/models/repositories/models/task.dart';
import 'package:todo_app/models/repositories/task_repository.dart';
import 'package:todo_app/routes/main/Task_page/slidable_task_item.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class TaskCalendar extends StatefulWidget {
  const TaskCalendar({ Key? key }) : super(key: key);

  @override
  _TaskCalendarState createState() => _TaskCalendarState();
}

class _TaskCalendarState extends State<TaskCalendar> {
  DateTime? _selectedDay;
  late final ValueNotifier<List<TaskModel>> _selectedTasks;
  DateTime _rangeStart = DateTime.utc(2010, 10, 16);
  DateTime _rangeEnd = DateTime.utc(2030, 3, 14);
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  TaskRepository _taskRepository = FakeTaskRepository();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedTasks = ValueNotifier(_taskRepository.getTaskListForDay('userID', _selectedDay!),);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              _selectedTasks.value = _taskRepository.getTaskListForDay('userID', selectedDay);
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
          eventLoader: (day) => _taskRepository.getTaskListForDay('userID', day),
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
          availableCalendarFormats: const{
            CalendarFormat.month: 'month',
            CalendarFormat.week: 'week',
          },
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0],
            weekdayStyle: const TextStyle(color: const Color.fromRGBO(154, 154, 154, 1)),
            weekendStyle: const TextStyle(color: const Color.fromRGBO(154, 154, 154, 1)),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(DateFormat('E, MMM d/yyyy').format(_selectedDay!).toUpperCase(), style: textDateStyle),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<TaskModel>>(
            valueListenable: _selectedTasks,
            builder: (context, value, _){
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index){
                  return TaskItem(task: value[index], deleteTask: deleteTask, key: Key(value[index].taskId),);
                },
              );
            },
          ),
        )
      ],
    );
  }

  void deleteTask(String id){
    setState(() {
      _taskRepository.deleteTask(id);
      _selectedTasks.value = _taskRepository.getTaskListForDay('userID', _selectedDay!);
    });
  }
}