import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    this.restorationId,
    required this.title,
    this.req,
    required this.onDateSelected,
    this.defaultValue, // Add defaultValue parameter
  });

  final String? title;
  final String? restorationId;
  final String? req;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime? defaultValue; // Add defaultValue field

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  late final RestorableDateTime _selectedDate = RestorableDateTime(
      widget.defaultValue ??
          DateTime.now()); // Initialize with defaultValue or current date

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2020),
          lastDate: DateTime(3000),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  var date;
  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));

        date = DateFormat('yyyy-MM-dd').format(newSelectedDate);
        widget.onDateSelected(newSelectedDate); // Call the callback function
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    date = date ??
        DateFormat('yyyy-MM-dd')
            .format(_selectedDate.value); // Format the default value date

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border(
            left: BorderSide(
              color: Color.fromARGB(255, 215, 213, 213),
              width: 0.5,
            ),
            top: BorderSide(
              color: Color.fromARGB(255, 215, 213, 213),
              width: 0.5,
            ),
            right: BorderSide(
              color: Color.fromARGB(255, 215, 213, 213),
              width: 0.5,
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.req == "true"
              ? Row(
                  children: [
                    Text(
                      "${widget.title}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 116, 113, 113)),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      "*",
                      style: TextStyle(
                          fontSize: 17, color: Color.fromARGB(255, 255, 0, 0)),
                    ),
                  ],
                )
              : Text(
                  "${widget.title}",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 116, 113, 113)),
                ),
          Row(
            children: [
              Text(
                "${date ?? ''}",
                style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  _restorableDatePickerRouteFuture.present();
                },
                child: const SizedBox(
                  width: 30,
                  height: 30,
                  child: Icon(
                    Icons.date_range,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
