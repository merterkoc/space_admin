import 'package:flutter/material.dart';

class SpaceDatePicker extends StatefulWidget {
  const SpaceDatePicker(
      {super.key, this.restorationId, required this.onDateSelected});

  final String? restorationId;
  final Function(DateTime) onDateSelected;

  @override
  State<SpaceDatePicker> createState() => _SpaceDatePickerState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _SpaceDatePickerState extends State<SpaceDatePicker>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(DateTime.now().year));
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
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year + 1),
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

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 200),
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
      widget.onDateSelected(_selectedDate.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        _restorableDatePickerRouteFuture.present();
      },
      child: Text(
        '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
      ),
    );
  }
}
