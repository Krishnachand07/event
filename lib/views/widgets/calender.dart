import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calender extends StatefulWidget {
  final void Function(DateTime date)? onDateChange;
  const Calender({super.key, this.onDateChange});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime date = DateTime.now();
  DateTime month = DateTime.now();
  int today = 0;
  int week = 0;
  bool isToday = false;
  bool isSelected = false;
  DateTime selectedDate = DateTime.now();
  List<DateTime> weeks = [];

  List<DateTime> generateWeek() {
    month = date.subtract(Duration(days: date.weekday - (7 * week)));
    return List.generate(7, (index) {
      return month.add(Duration(days: index));
    });
  }

  @override
  void initState() {
    super.initState();
    today = date.day;
    if (date.weekday == 7) {
      week++;
    }
    weeks = generateWeek();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: week == 0 || date.weekday == 7
                      ? null
                      : () {
                          week--;
                          weeks = generateWeek();
                          setState(() {});
                        },
                  icon: const Icon(CupertinoIcons.back)),
              Text(
                DateFormat("MMM yyyy").format(month),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                  onPressed: () {
                    week++;
                    weeks = generateWeek();
                    setState(() {});
                  },
                  icon: const Icon(CupertinoIcons.forward)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(weeks.length, (index) {
                if (DateTime(weeks[index].year, weeks[index].month,
                        weeks[index].day) ==
                    DateTime(date.year, date.month, date.day)) {
                  isToday = true;
                } else {
                  isToday = false;
                }
                isSelected = selectedDate.compareTo(weeks[index]) == 0;
                return GestureDetector(
                  onTap: week == 0 &&
                          DateTime(weeks[index].year, weeks[index].month,
                                      weeks[index].day)
                                  .compareTo(DateTime(
                                      date.year, date.month, date.day)) !=
                              0 &&
                          weeks[index].isBefore(date)
                      ? null
                      : () {
                          selectedDate = weeks[index];
                          widget.onDateChange!(selectedDate);
                          setState(() {});
                        },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: (isToday || isSelected) && isSelected
                        ? BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8))
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat("E").format(weeks[index]),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: isToday ? FontWeight.bold : null,
                                  color: (isToday || isSelected) && isSelected
                                      ? Colors.white
                                      : isToday && !isSelected
                                          ? Theme.of(context).primaryColor
                                          : week == 0 &&
                                                  weeks[index].isBefore(date)
                                              ? Theme.of(context).disabledColor
                                              : null),
                        ),
                        Text(
                          DateFormat("dd").format(weeks[index]),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: isToday || isSelected
                                      ? FontWeight.bold
                                      : null,
                                  color: (isToday || isSelected) && isSelected
                                      ? Colors.white
                                      : isToday && !isSelected
                                          ? Theme.of(context).primaryColor
                                          : week == 0 &&
                                                  weeks[index].isBefore(date)
                                              ? Theme.of(context).disabledColor
                                              : null),
                        ),
                        if (isToday && !isSelected)
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: CircleAvatar(
                              radius: 3,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          )
                      ],
                    ),
                  ),
                );
              }),
            ],
          )
        ],
      ),
    );
  }
}
