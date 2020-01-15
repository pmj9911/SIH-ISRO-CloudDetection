import 'package:flutter/material.dart';

class OverlayDetails extends StatefulWidget {
  final double overlayWidth = 175;
  final double overlayHeight = 175;
  final double overlayLeftDistance;
  final double overlayBottomDistance;
  final String toBeDisplayed;

  OverlayDetails(
      this.toBeDisplayed, this.overlayBottomDistance, this.overlayLeftDistance);
  @override
  _OverlayDetailsState createState() => _OverlayDetailsState();
}

class _OverlayDetailsState extends State<OverlayDetails> {
  @override
  Widget build(BuildContext context) {
    return //Row(
        // children: <Widget>[
        Positioned(
      top: widget.overlayBottomDistance,
      left: widget.overlayLeftDistance,
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              widget.toBeDisplayed,
              // overflow: TextOverflow.clip,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        width: widget.overlayWidth,
        height: widget.overlayHeight,
        // margin: const EdgeInsets.all(15.0),
        // padding: const EdgeInsets.all(3.0),

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          border: Border.all(
            color: Colors.green,
            width: 2.5,
          ),
        ),
      ),
      // ),
      //   Positioned(
      //     top: widget.overlayBottomDistance,
      //     left: widget.overlayLeftDistance,
      //     child: Container(
      //       width: 10.0,
      //       height: 10.0,
      //       decoration: new BoxDecoration(
      //         color: Colors.orange,
      //         shape: BoxShape.circle,
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}
