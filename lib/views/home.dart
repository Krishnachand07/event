import 'package:event/theme/custom_theme.dart';
import 'package:event/views/bloc/calendar_bloc.dart';
import 'package:event/views/widgets/calender.dart';
import 'package:event/views/widgets/event_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CustomThemeProvider themeProvider;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    themeProvider = context.read<CustomThemeProvider>();
    context.read<CalendarBloc>().add(GetEvent());
    context.read<CalendarBloc>().add(SpecificEvent(date: selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar event'),
          actions: [
            IconButton(
                onPressed: () {
                  if (themeProvider.currentThemeMode == ThemeMode.light) {
                    themeProvider.setThemeMode(ThemeMode.dark);
                  } else {
                    themeProvider.setThemeMode(ThemeMode.light);
                  }
                },
                icon: Icon(
                    isDark ? CupertinoIcons.sun_max : CupertinoIcons.moon_fill))
          ],
        ),
        body: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Calender(
                      onDateChange: (date) {
                        selectedDate = date;
                        context
                            .read<CalendarBloc>()
                            .add(SpecificEvent(date: date));
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    if (selectedDate != DateTime(1000))
                      Text(
                        "${DateFormat("E dd MMM").format(selectedDate)}, Total events: ${state.event.length}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state.event.isNotEmpty)
                      Expanded(
                        child: RawScrollbar(
                          thumbColor: Theme.of(context).primaryColor,
                          trackVisibility: true,
                          thickness: 12,
                          thumbVisibility: true,
                          radius: const Radius.circular(30),
                          interactive: true,
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                  state.event.length,
                                  (index) =>
                                      EventCard(event: state.event[index])),
                            ),
                          ),
                        ),
                      )
                    else
                      const Expanded(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.exclamationmark_triangle_fill,
                              size: 90,
                              color: Colors.amber,
                            ),
                            Text('No events found!'),
                          ],
                        )),
                      )
                  ],
                ));
          },
        ));
  }
}
