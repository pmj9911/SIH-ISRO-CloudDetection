import 'package:flutter/material.dart';

import 'input_image_screen.dart';
import 'overlay_details_widget.dart';

class CloudDetectionScreen extends StatefulWidget {
  final double heightImg = 300;
  // CloudScreen(this.heightImg);
  @override
  _CloudDetectionScreenState createState() => _CloudDetectionScreenState();
}

class _CloudDetectionScreenState extends State<CloudDetectionScreen> {
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
    Widget inputBox = Stack(
      children: <Widget>[
        InputImageScreen("assets/images/cloud1.jpg", widget.heightImg),
        OverlayDetails("overlay details", 0, 0),
      ],
    );
    Widget outputBox = Stack(
      children: <Widget>[
        InputImageScreen("assets/images/cloud1.jpg", widget.heightImg),
        OverlayDetails("overlay details ", 125, 184),
      ],
    );
    Widget castButton = IconButton(
      onPressed: () {
        setState(() {
          buttonPressed = true;
        });
        print("button pressed");
      },
      icon: Icon(
        Icons.cast,
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buttonPressed ? SizedBox() : inputBox,
            buttonPressed ? SizedBox() : castButton,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buttonPressed
                  ? Center(
                      child: Text(
                        "Output Image",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
            buttonPressed ? outputBox : SizedBox(),
            buttonPressed ? resultContainer : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buttonPressed
                  ? Center(
                      child: Text(
                        "Input Image",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
            buttonPressed ? inputBox : SizedBox(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            buttonPressed = false;
          });
        },
      ),
    );
  }
}
