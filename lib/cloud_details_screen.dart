import 'package:flutter/material.dart';

import 'input_image_screen.dart';

class CloudDetails extends StatefulWidget {
  @override
  _CloudDetailsState createState() => _CloudDetailsState();
}

class _CloudDetailsState extends State<CloudDetails> {
  Widget resultContainer() {
    return Container(
      child: Text("details of point selected"),
      // mainAxisAlignment: MainAxisAlignment.center,
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.only(top: 15),
      // padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 3.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InputImageScreen("assets/images/cloud1.jpg", 300),
        resultContainer(),
      ],
    );
  }
}
