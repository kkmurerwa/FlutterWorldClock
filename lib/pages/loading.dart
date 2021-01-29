import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = "Loading...";

  void setUpWorldTime() async {
    WorldTime instance = WorldTime(location: "Nairobi", flagUrl: "kenya.png", locationUrl: "Africa/Nairobi");

    await instance.getTime();

    // Open home page on response and prevent loader from being saved on backstack
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      "location": instance.location,
      "flag": instance.flagUrl,
      "time": instance.time,
      "is_daytime": instance.isDayTime,
    });
  }


  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 300.0),
          child: Column(
            children: <Widget> [
              SpinKitCubeGrid(
                color: Colors.green[700],
                size: 80.0,
              ),
              SizedBox(height: 20.0),
              Text(
                "Loading cities",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.green[700],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
