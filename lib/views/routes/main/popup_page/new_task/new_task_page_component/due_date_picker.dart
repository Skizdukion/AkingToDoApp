import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_event.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_state.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DueDatePicker extends StatefulWidget {
  const DueDatePicker({Key? key}) : super(key: key);

  @override
  _DueDatePickerState createState() => _DueDatePickerState();
}

class _DueDatePickerState extends State<DueDatePicker> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskBloc, NewTaskState>(builder: (context, state) {
      return Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 244, 1),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 25.w,
            ),
            Text(
              'Due Date',
              style: AppTextDecoration.darkW400S16,
            ),
            SizedBox(
              width: 10.w,
            ),
            TextButton(
              child: Text(
                (state.dueDate == null)
                    ? 'Anytime'
                    : DateFormat('MMM d/yyyy').format(state.dueDate!),
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              onPressed: () {
                _showAddMenu();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(96, 116, 249, 1)),
              ),
            ),
          ],
        ),
      );
    });
  }

  _showAddMenu() async {
    DateTime? dueDate = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CalendarPicker(),
                ),
                insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
              ));
        });
    if (dueDate != null)
      context.read<NewTaskBloc>().add(DueDateOnChange(dueDate: dueDate));
  }
}

class CalendarPicker extends StatefulWidget {
  const CalendarPicker({Key? key}) : super(key: key);

  @override
  _CalendarPickerState createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  DateTime _rangeStart = DateTime.utc(2010, 10, 16);
  DateTime _rangeEnd = DateTime.utc(2030, 3, 14);
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 440.h,
      child: Column(
        children: [
          TableCalendar(
            rowHeight: 40.h,
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
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color.fromRGBO(96, 116, 249, 1),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
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
              headerPadding: EdgeInsets.symmetric(vertical: 20.h),
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
          StrechButton(
            text: 'Done',
            onPressed: () {
              Navigator.pop(context, _selectedDay);
            },
            buttonStyle: AppButtonDecoration.authenticate2,
            horizontalPadding: 80.w,
          ),
        ],
      ),
    );
  }
}
