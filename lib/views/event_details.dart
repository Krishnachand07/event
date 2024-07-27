import 'package:event/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  final Event event;
  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ListTile(
                subtitle: Text(
                  event.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 22),
                ),
                title: Text(
                  'Event Title',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Created date"),
                    Text(
                      DateFormat("dd MMM yyyy").format(event.createdAt!),
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
              ListTile(
                subtitle: Text(
                  event.description,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                title: Text(
                  'Event description',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const Divider(height: 30),
              ListTile(
                leading: const CircleAvatar(
                    child: Icon(CupertinoIcons.calendar_today)),
                subtitle: Text(
                  DateFormat("dd MMM yyyy").format(event.startedAt!),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                title: Text(
                  'Event starts date',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: event.status == EventStatus.cancel
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.red.withOpacity(.2),
                            child: const Icon(
                              CupertinoIcons.clear_circled_solid,
                              color: Colors.red,
                            ),
                          ),
                          const Text('Cancelled')
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            child: Icon(
                              CupertinoIcons.checkmark_alt_circle_fill,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const Text('Confirmed')
                        ],
                      ),
              ),
              ListTile(
                leading:
                    const CircleAvatar(child: Icon(CupertinoIcons.time_solid)),
                subtitle: Text(
                  "${event.duration} mins",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                title: Text(
                  'Event duration',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        "Starts at: ${DateFormat("hh:mm a").format(event.startedAt!)}"),
                    Text(
                        "ends at: ${DateFormat("hh:mm a").format(DateTime(event.startedAt!.year, event.startedAt!.month, event.startedAt!.day, event.startedAt!.hour, event.startedAt!.minute + event.duration, event.startedAt!.second))}")
                  ],
                ),
              ),
              const Divider(height: 30),
              if (event.images != null && event.images!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event images',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ...List.generate(event.images!.length, (index) {
                      final image = event.images![index];
                      return Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            image,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    })
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
