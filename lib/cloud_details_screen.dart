import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'cloud_details_widget.dart';
import 'getter_input_image.dart';

class PointDetails {
  final String posx;
  final String posy;
  final String tir1Count;
  final bool cloudy;
  final String type;
  final String topTemp;
  final String height;

  PointDetails({
    this.posx,
    this.posy,
    this.tir1Count,
    this.cloudy,
    this.type,
    this.topTemp,
    this.height,
  });

  factory PointDetails.fromJson(Map<String, dynamic> json) {
    return PointDetails(
      posx: json['posx'],
      posy: json['posy'],
      tir1Count: json['tir1Count'],
      cloudy: json['cloudy'],
      type: json['type'],
      topTemp: json['topTemp'],
      height: json['height'],
    );
  }
}

//###################################33
class PointCoordiantes {
  final int posx;
  final int posy;
  PointCoordiantes(this.posx, this.posy);

  Map<String, String> toJson() => {
        "posx": posx.toString(),
        "posy": posy.toString(),
      };
}

String postToJson(PointCoordiantes pointCoordiantes) {
  final cord = pointCoordiantes.toJson();
  return json.encode(cord);
}

Future<http.Response> sendCords(PointCoordiantes pointCoordiantes) async {
  print('@@@@@@@@@@ ${postToJson(pointCoordiantes)}');
  final response = await http.post(
    'http://c4fc68eb.ngrok.io/detailsCloud',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: postToJson(pointCoordiantes),
  );
  print('####### ${response.body.toString()}');
  return response;
}

class CloudDetails extends StatefulWidget {
  @override
  _CloudDetailsState createState() => _CloudDetailsState();
}

class _CloudDetailsState extends State<CloudDetails> {
  int posx = 0;
  int posy = 0;
  bool overlayActive = false;
  bool spinner = false;
  PointDetails postDets;
  void onTapDown(BuildContext context, TapDownDetails details) {
    // setState(() {
    //   spinner = true;
    // });
    print('${details.globalPosition}##################');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    posx = localOffset.dx.toInt();
    posy = localOffset.dy.toInt();
    print("$posx  $posy");

    PointCoordiantes pointCords = new PointCoordiantes(posx, posy);

    print("sending post request");
    sendCords(pointCords).then((response) {
      print("processing the response from the post request");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        postDets = PointDetails.fromJson(json.decode(response.body));
      } else {
        print(json.decode(response.body));
        throw Exception('Failed to load post');
      }
      setState(() {
        overlayActive = true;
        // spinner = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                onTapDown: (TapDownDetails details) =>
                    onTapDown(context, details),
                child: GetterInputImage(),
              ),
            ],
          ),
          Container(
            height: 288,
            // width: double.infinity,
            child: overlayActive
                ? PointCloudDetails(postDets)
                : Center(
                    child: Text("No point selected !"),
                  ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            overlayActive = false;
          });
        },
      ),
    );
  }
}
