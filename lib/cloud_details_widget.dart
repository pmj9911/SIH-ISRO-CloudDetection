// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'cloud_details_screen.dart';
// String postFromJson(PointCoordiantes pointCoordiantes) {
//   final cord = pointCoordiantes.fromJson();
//   return json.encode(cord);
// }

// class PointDetails {
//   final int posx;
//   final int posy;
//   final double tir1Count;
//   final bool cloudy;
//   final String type;
//   final String topTemp;
//   final String height;

//   PointDetails({
//     this.posx,
//     this.posy,
//     this.tir1Count,
//     this.cloudy,
//     this.type,
//     this.topTemp,
//     this.height,
//   });

//   factory PointDetails.fromJson(Map<String, dynamic> json) {
//     return PointDetails(
//       posx: json['posx'],
//       posy: json['posy'],
//       tir1Count: json['tir1Count'],
//       cloudy: json['cloudy'],
//       type: json['type'],
//       topTemp: json['topTemp'],
//       height: json['height'],
//     );
//   }
// }

// Future<PointDetails> getPointDetails() async {
//   String url = 'https://c4fc68eb.ngrok.io/detailsCloud';
//   final response = await http.get(url, headers: {"Accept": "application/json"});

//   if (response.statusCode == 200) {
//     print(json.decode(response.body));
//     return PointDetails.fromJson(json.decode(response.body));
//   } else {
//     print(json.decode(response.body));
//     throw Exception('Failed to load post');
//   }
// }

class PointCloudDetails extends StatefulWidget {
  
  final PointDetails allDetails;
  PointCloudDetails(this.allDetails);

  @override
  _PointCloudDetailsState createState() => _PointCloudDetailsState();
}

class _PointCloudDetailsState extends State<PointCloudDetails> {
  Widget detailResult(String infoText, String value) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            infoText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
            children: <Widget>[
              detailResult('Position : ',
                  '${widget.allDetails.posx.toString()} , ${widget.allDetails.posy}'),
              detailResult('TIR1 Count : ', widget.allDetails.tir1Count.toString()),
              detailResult('Cloudy : ', widget.allDetails.cloudy.toString()),
              detailResult('Type : ', widget.allDetails.type.toString()),
              detailResult('Top Temp : ', widget.allDetails.topTemp.toString()),
              detailResult('Height : ', widget.allDetails.height.toString()),
            ],
  
            // mainAxisAlignment: MainAxisAlignment.center,
            // margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(15.0),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.red,
            //     width: 3.5,
            //   ),
            // ),
          );
    //  FutureBuilder<PointDetails>(
    //   future:
    //       getPointDetails(), //sets the getPointDetails method as the expected Future
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       //checks if the response returns valid data
    //       return ListView(
    //         children: <Widget>[
    //           detailResult('Position : ',
    //               '${snapshot.data.posx.toString()} , ${snapshot.data.posy}'),
    //           detailResult('TIR1 Count : ', snapshot.data.tir1Count.toString()),
    //           detailResult('Cloudy : ', snapshot.data.cloudy.toString()),
    //           detailResult('Type : ', snapshot.data.type.toString()),
    //           detailResult('Top Temp : ', snapshot.data.topTemp.toString()),
    //           detailResult('Height : ', snapshot.data.height.toString()),
    //         ],

    //         // mainAxisAlignment: MainAxisAlignment.center,
    //         // margin: const EdgeInsets.all(15.0),
    //         padding: const EdgeInsets.all(15.0),
    //         // decoration: BoxDecoration(
    //         //   border: Border.all(
    //         //     color: Colors.red,
    //         //     width: 3.5,
    //         //   ),
    //         // ),
    //       );
    //     } else if (snapshot.hasError) {
    //       //checks if the response throws an error
    //       return Text("${snapshot.error}");
    //     }
    //     return Padding(
    //       padding: const EdgeInsets.only(
    //         top: 115,
    //         bottom: 115,
    //         // left: 100,
    //         // right: 100,
    //       ),
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }
}
