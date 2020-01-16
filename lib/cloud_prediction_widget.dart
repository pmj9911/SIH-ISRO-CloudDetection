import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CloudPredict {
  final String timeSlot;
  final String direction;
  final String speed;

  CloudPredict({
    this.timeSlot,
    this.direction,
    this.speed,
  });

  factory CloudPredict.fromJson(Map<String, dynamic> json) {
    return CloudPredict(
      timeSlot: json['time_slot'],
      direction: json['direction'],
      speed: json['speed'],
    );
  }
}

Future<CloudPredict> getCloudPredict() async {
  String url = 'https://88e84f7d.ngrok.io/predictCloud';
  final response = await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return CloudPredict.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class CloudPrediction extends StatefulWidget {
  @override
  CloudPredictionState createState() => CloudPredictionState();
}

class CloudPredictionState extends State<CloudPrediction> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CloudPredict>(
      future:
          getCloudPredict(), //sets the getCloudPredict method as the expected Future
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //checks if the response returns valid data
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Time Slot : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(snapshot.data.timeSlot),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Direction : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(snapshot.data.direction),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Speed : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(snapshot.data.speed),
                  ],
                ),
              ],
            ),
            // mainAxisAlignment: MainAxisAlignment.center,
            width: double.infinity,
            height: 150,
            // margin: const EdgeInsets.all(15.0),
            // padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 3.5,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          //checks if the response throws an error
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
