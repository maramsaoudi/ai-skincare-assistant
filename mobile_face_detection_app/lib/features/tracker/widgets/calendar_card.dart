import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  static const primary = Color(0xFFF06090);

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _card(),
      child: TableCalendar(
        firstDay: DateTime.utc(2020),
        lastDay: DateTime.utc(2035),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selected, focused) {
          setState(() {
            _selectedDay = selected;
            _focusedDay = focused;
          });
        },
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            color: primary,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: primary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  BoxDecoration _card() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    );
  }
}
