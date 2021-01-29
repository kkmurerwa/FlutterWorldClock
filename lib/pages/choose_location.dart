import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';


class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Map data = {};

  List<WorldTime> locations = [
    WorldTime(locationUrl: 'Europe/London', location: 'London', flagUrl: 'uk.png'),
    WorldTime(locationUrl: 'Europe/Berlin', location: 'Athens', flagUrl: 'greece.png'),
    WorldTime(locationUrl: 'Africa/Cairo', location: 'Cairo', flagUrl: 'egypt.png'),
    WorldTime(locationUrl: 'Africa/Nairobi', location: 'Nairobi', flagUrl: 'kenya.png'),
    WorldTime(locationUrl: 'America/Chicago', location: 'Chicago', flagUrl: 'usa.png'),
    WorldTime(locationUrl: 'America/New_York', location: 'New York', flagUrl: 'usa.png'),
    WorldTime(locationUrl: 'Asia/Seoul', location: 'Seoul', flagUrl: 'south_korea.png'),
    WorldTime(locationUrl: 'Asia/Jakarta', location: 'Jakarta', flagUrl: 'indonesia.png'),
  ];

  void updateTime(index) async {
    // Get current instance
    WorldTime currentItem = locations[index];

    // Get current time
    await currentItem.getTime();

    Navigator.pop(context, {
      "location": currentItem.location,
      "flag": currentItem.flagUrl,
      "time": currentItem.time,
      "is_daytime": currentItem.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    // Get color argument from calling activity
    Color bgColor = data["nav_color"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          "Choose location"
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  // String timeURL = locations[index].locationUrl;
                  // print(timeURL);
                  updateTime(index);
                },
                title: Text(
                    locations[index].location
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flagUrl}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
