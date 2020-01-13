import 'package:flutter/material.dart';

import 'input_image_screen.dart';
import 'overlay_details_widget.dart';

class CloudScreen extends StatefulWidget {
  final double heightImg = 300;
  // CloudScreen(this.heightImg);
  @override
  _CloudScreenState createState() => _CloudScreenState();
}

class _CloudScreenState extends State<CloudScreen> {
  bool buttonPressed = false;
  Widget resultContainer = Container(
    child: Text("results"),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            InputImageScreen(
                "assets/images/cloud1.jpg", !buttonPressed ? 300 : 150),
            OverlayDetails("overlay details", 0, 0),
          ],
        ),
        IconButton(
          onPressed: () {
            setState(() {
              buttonPressed = true;
            });
            print("button pressed");
          },
          icon: Icon(
            Icons.cast,
          ),
        ),
        !buttonPressed ? SizedBox() : resultContainer,
        Stack(
          children: <Widget>[
            InputImageScreen("assets/images/cloud1.jpg", 300),
            OverlayDetails("overlay details ", 125, 184),
          ],
        ),
      ],
    );
  }
}
