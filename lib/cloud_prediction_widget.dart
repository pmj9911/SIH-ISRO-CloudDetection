import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'input_image_screen.dart';

class CloudPredict {
  final String timeSlot;
  final String direction;
  final String speed;
  final String fileName;
  CloudPredict({this.timeSlot, this.direction, this.speed, this.fileName});

  factory CloudPredict.fromJson(Map<String, dynamic> json) {
    return CloudPredict(
      timeSlot: json['time_slot'],
      direction: json['direction'],
      speed: json['speed'],
      fileName: json['output_fileName'],
    );
  }
}

Future<CloudPredict> getCloudPredict() async {
  String url = 'https://eed6cd576529.ngrok.io/predictCloud';
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
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss').format(now);
    print(formattedDate);
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
                      'Day : ',
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
                      'Input Images of : ',
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
                      'Predicted Images for : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(snapshot.data.speed),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Output Image",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                InputImageScreen(snapshot.data.fileName, 300),
              ],
            ),
            // mainAxisAlignment: MainAxisAlignment.center,
            width: double.infinity,
            height: 460,
            // margin: const EdgeInsets.all(15.0),
            // padding: const EdgeInsets.all(3.0),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.red,
            //     width: 3.5,
            //   ),
            // ),
          );
        } else if (snapshot.hasError) {
          //checks if the response throws an error
          return Text("${snapshot.error}");
        }
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          // mainAxisAlignment: MainAxisAlignment.center,
          width: double.infinity,
          height: 350,
          // margin: const EdgeInsets.all(15.0),
          // padding: const EdgeInsets.all(3.0),
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     color: Colors.red,
          //     width: 3.5,
          //   ),
          // ),
        );
      },
    );
  }
}
