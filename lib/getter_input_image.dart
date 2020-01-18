import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'input_image_screen.dart';

class CloudPredict {
  final String inputFileName;
  CloudPredict({this.inputFileName});

  factory CloudPredict.fromJson(Map<String, dynamic> json) {
    return CloudPredict(
      inputFileName: json['input_fileName'],
    );
  }
}

Future<CloudPredict> getInputImageFileName() async {
  String url = 'https://c4fc68eb.ngrok.io/predictCloud';
  final response = await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return CloudPredict.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class GetterInputImage extends StatefulWidget {
  @override
  _GetterInputImageState createState() => _GetterInputImageState();
}

class _GetterInputImageState extends State<GetterInputImage> {
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<CloudPredict>(
      future:
          getInputImageFileName(), //sets the getInputImageFileName method as the expected Future
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //checks if the response returns valid data
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Text(
                      "Input Image",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                InputImageScreen("BW/${snapshot.data.inputFileName}", 300),
              ],
            ),
            // mainAxisAlignment: MainAxisAlignment.center,
            width: double.infinity,
            height: 350,
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
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              width: 3.5,
            ),
          ),
        );
      },
    );
  }
}

//"InputImage1.jpeg", widget.heightImg);
