import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  // Variables for UI
  String location, time, flagUrl, locationUrl;
  bool isDayTime;

  // Constructor
  WorldTime({
    this.location,
    this.flagUrl,
    this.locationUrl
  });

  Future<void> getTime() async {
    try {
      // Make API Request
      Response response = await get("http://worldtimeapi.org/api/timezone/$locationUrl");
      Map data = jsonDecode(response.body);
      // print(data);

      // Get properties from response map
      String dateTime = data["datetime"];
      String offset = data["utc_offset"].substring(0, 3);

      // Convert to DateTime
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      print(dateTime);
      // Set time property
      time = DateFormat.jm().format(now);

      print(time);
      // set daytime checker
      isDayTime = now.hour >6 && now.hour <19;
    } catch (exception) {
      print(exception);
      time = "Could not load time";
    }
  }
}