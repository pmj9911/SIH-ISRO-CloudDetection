import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'cloud_details_widget.dart';
import 'input_image_screen.dart';

class PointCoordiantes {
  final int posx;
  final int posy;
  PointCoordiantes(this.posx, this.posy);

  Map<String, String> toJson() => {
        "posx": posx.toString(),
        "posy": posy.toString(),
      };
  // Map<String, dynamic> fromJson() => {
  //       posx: json['posx'].to,
  //       posy: json['posy'],
  //     };
}

String postToJson(PointCoordiantes pointCoordiantes) {
  final cord = pointCoordiantes.toJson();
  // print(cord);
  return json.encode(cord);
}

Future<http.Response> sendCords(PointCoordiantes pointCoordiantes) async {
  print('@@@@@@@@@@ ${postToJson(pointCoordiantes)}');
  final response = await http.post(
    'http://88e84f7d.ngrok.io/detailsCloud',
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
  double posx = 0.0;
  double posy = 0.0;
  bool overlayActive = false;
  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}##################');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    posx = localOffset.dx;
    posy = localOffset.dy;
    print("$posx  $posy");

    PointCoordiantes pointCords =
        new PointCoordiantes(posx.toInt(), posy.toInt());
    print("sending post request");
    sendCords(pointCords).then((response) {
      setState(() {
        overlayActive = true;
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
                child: new InputImageScreen("cloud1.jpg", 300),
              ),
            ],
          ),
          Container(
            height: 330,
            // width: double.infinity,
            child: overlayActive
                ? PointCloudDetails()
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
