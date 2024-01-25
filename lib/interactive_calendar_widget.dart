import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/main.dart';
import 'package:notes/note_page.dart';
import 'package:table_calendar/table_calendar.dart';

class InteractiveCalendar extends StatefulWidget {
  const InteractiveCalendar({
    Key? key,
    required this.boxType,
  }) : super(key: key);

  final Box<Note> boxType;

  @override
  State<InteractiveCalendar> createState() => _InteractiveCalendarState();
}

class _InteractiveCalendarState extends State<InteractiveCalendar> {
  late DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2024),
      lastDay: DateTime.now(),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotePage()),
          );
        });
      },
    );
  }
}
