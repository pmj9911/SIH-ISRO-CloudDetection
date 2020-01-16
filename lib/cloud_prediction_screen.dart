import 'package:flutter/material.dart';
import 'input_image_screen.dart';
import 'cloud_prediction_widget.dart';

class CloudPredictionScreen extends StatefulWidget {
  final double heightImg = 300;
  // CloudScreen(this.heightImg);
  @override
  _CloudPredictionScreenState createState() => _CloudPredictionScreenState();
}

class _CloudPredictionScreenState extends State<CloudPredictionScreen> {
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    Widget inputImage = InputImageScreen("InputImage1.jpeg", widget.heightImg);
    Widget castButton = Container(
      height: 330,
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buttonPressed ? SizedBox() : inputImage,
            buttonPressed ? SizedBox() : castButton,
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
            // buttonPressed ? outputImage : SizedBox(),
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
            buttonPressed ? inputImage : SizedBox(),
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
