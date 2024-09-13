import 'package:flutter/material.dart';

import '../constants/color.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key, required this.callback, this.value});

  final void Function(String) callback;
  final String? value;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool isNewDateTimeChoosed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () => _selectDateTime(context),
          child: const Text('Deadline', style: TextStyle(color: titlecolor)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            !isNewDateTimeChoosed && widget.value != null
                ? widget.value!
                : getFormattedDateTime(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  String getFormattedDateTime() {
    if (_selectedDate == null || _selectedTime == null) {
      return 'No Date/Time Chosen';
    }

    // Create DateTime object with the selected date and time.
    final DateTime dateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    // Convert to UTC.
    final DateTime utcDateTime = dateTime.toUtc();

    // Format the DateTime to ISO 8601 with milliseconds.
    final isoDateTime = utcDateTime.toIso8601String();
    widget.callback(isoDateTime);

    return isoDateTime;
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && context.mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDate = pickedDate;
          _selectedTime = pickedTime;
        });
      }
      setState(() {
        isNewDateTimeChoosed = true;
      });
    }
  }
}
