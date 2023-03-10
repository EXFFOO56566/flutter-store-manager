import 'package:flutter/material.dart';
import 'package:flutter_store_manager/common/widgets/date_picker.dart';
import 'package:intl/intl.dart';

class DateRangePickerWidget extends StatefulWidget {
  final Function(DateTime? start, DateTime? end) onChange;
  final DateTime? start;
  final DateTime? end;
  final String? title;
  final double? height;
  final double? width;
  final Color? colorLabel;

  const DateRangePickerWidget(
      {Key? key, required this.onChange, this.start, this.end, this.title, this.height, this.width, this.colorLabel})
      : super(key: key);

  @override
  DateRangePickerWidgetState createState() => DateRangePickerWidgetState();
}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange? dateRange;

  String getFrom() {
    if (dateRange == null) {
      return '';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return '';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.end);
    }
  }

  @override
  void initState() {
    if (widget.start != null) {
      if (widget.end != null) {
        DateTimeRange initialDateRange = DateTimeRange(start: widget.start!, end: widget.end!);
        dateRange = initialDateRange;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pickDateRange(context);
      },
      child: Container(
        width: (widget.width ?? 200) - 32,
        height: (widget.height) ?? 56,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (dateRange != null) ? "Custom: ${getFrom()} - ${getUntil()}" : "Custom: Choose Date Range",
              style: TextStyle(color: widget.colorLabel ?? Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePickers(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );
    setState(() {
      dateRange = newDateRange;
      widget.onChange((dateRange != null) ? dateRange!.start : null, (dateRange != null) ? dateRange!.end : null);
    });
  }
}
