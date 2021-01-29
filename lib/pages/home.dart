// import 'dart:html';
// import 'package:world_time/assets/*';

import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    // Assign passed variables to map field
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    String bgImage = data["is_daytime"] ? 'day.png' : 'night.png';
    Color notifBarColor = data["is_daytime"] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: notifBarColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                    color: Colors.green[900],
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, "/location", arguments: {
                        "nav_color" : notifBarColor
                      });
                      setState(() {
                        data = {
                          "location": result["location"],
                          "flag": result["flag"],
                          "time": result["time"],
                          "is_daytime": result["is_daytime"],
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Edit location",
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Text(data["location"],
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.grey[300],
                          letterSpacing: 2.0
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    data["time"],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
