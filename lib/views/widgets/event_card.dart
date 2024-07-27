import 'package:event/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/event', arguments: {"event": event}),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading:
                    const CircleAvatar(child: Icon(CupertinoIcons.calendar)),
                title: Text(
                  event.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  DateFormat("dd MMM yyyy").format(event.createdAt!),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: CircleAvatar(
                  backgroundColor: event.status == EventStatus.cancel
                      ? Colors.red.withOpacity(.2)
                      : null,
                  child: Icon(
                    event.status == EventStatus.cancel
                        ? CupertinoIcons.clear_circled_solid
                        : CupertinoIcons.check_mark_circled_solid,
                    color: event.status == EventStatus.cancel
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Start date: ${DateFormat("dd MMM yyyy").format(event.startedAt!)}"),
                    Text("Duration: ${event.duration}mins"),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
