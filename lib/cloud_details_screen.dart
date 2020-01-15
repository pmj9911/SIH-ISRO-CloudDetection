import 'package:flutter/material.dart';

import 'cloud_details_widget.dart';
import 'input_image_screen.dart';

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
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      print("$posx  $posy");
      overlayActive = true;
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
                child: InputImageScreen("cloud1.jpg", 300),
              ),
            ],
          ),
          Container(
            height: 330,
            // width: double.infinity,
            child: overlayActive
                ? PointCloudDetails(posx, posy)
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
