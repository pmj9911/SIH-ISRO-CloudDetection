import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'getter_input_image.dart';
import 'cloud_prediction_widget.dart';

class CloudPredictionScreen extends StatefulWidget {
  final double heightImg = 300;
  // CloudScreen(this.heightImg);
  @override
  _CloudPredictionScreenState createState() => _CloudPredictionScreenState();
}

class _CloudPredictionScreenState extends State<CloudPredictionScreen> {
  bool buttonPressed = false;
  bool refereshImage = true;
  Timer _timer;
  // _CloudPredictionScreenState() {
  //   _timer = new Timer(const Duration(milliseconds: 1000), () {
  //     setState(() {
  //       buttonPressed = false;
  //     });
  //   });
  // }
  void addValue() {
    setState(() {
      buttonPressed = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 180  ), (Timer t) => addValue());
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Widget castButton = Container(
      height: 270,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 2.5,
        ),
      ),
      // padding: EdgeInsets.only(top: 75),
      child: FlatButton.icon(
        label: Text("NowCast"),
        onPressed: () {
          setState(() {
            buttonPressed = true;
          });
          print("button pressed");
        },
        icon: Icon(
          Icons.fast_forward,
          size: 40,
        ),
      ),
    );
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss').format(now);
    print(formattedDate);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buttonPressed
                  ? Center(
                      child: Text(
                        "Predictions",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
            buttonPressed ? CloudPrediction() : SizedBox(),
            refereshImage ? GetterInputImage() : SizedBox(),
            buttonPressed ? SizedBox() : castButton,
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
