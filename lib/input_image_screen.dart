import 'package:flutter/material.dart';

class InputImageScreen extends StatefulWidget {
  final double heightImg ;
  final String pathToImage;
  InputImageScreen(this.pathToImage,this.heightImg);
  @override
  _InputImageScreenState createState() => _InputImageScreenState();
}

class _InputImageScreenState extends State<InputImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        widget.pathToImage,
        fit: BoxFit.fill,
      ),
      // mainAxisAlignment: MainAxisAlignment.center,
      width: double.infinity,
      height: widget.heightImg,
      // margin: const EdgeInsets.all(15.0),
      // padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 3.5,
        ),
      ),
    );
  }
}
