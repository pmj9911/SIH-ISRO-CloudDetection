import 'package:flutter/material.dart';

class InputImageScreen extends StatefulWidget {
  final double heightImg;
  final String pathToImage;
  InputImageScreen(this.pathToImage, this.heightImg);
  @override
  _InputImageScreenState createState() => _InputImageScreenState();
}

class _InputImageScreenState extends State<InputImageScreen> {
  
  // img = 'https://f45f6453.ngrok.io/media/images/' + widget.pathToImage

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Image.network(
        'https://c4fc68eb.ngrok.io/media/images/' + widget.pathToImage,
        fit: BoxFit.fill,
      ),
      // Image.asset(
      //   widget.pathToImage,
      //   fit: BoxFit.fill,
      // ),
      width: double.infinity,
      height: widget.heightImg,
      // margin: const EdgeInsets.all(15.0),
      // padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 1,
        ),
      ),
    );
  }
}
