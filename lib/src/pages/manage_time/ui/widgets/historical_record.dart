import 'package:flutter/material.dart';

class HistoricalRecord extends StatelessWidget {
  final String name;
  // final DateTime end;
  // final DateTime begin;
  final String end;
  final String begin;

  final String pathImage;

  HistoricalRecord(this.pathImage, this.name, this.begin, this.end);
  @override
  Widget build(BuildContext context) {
    final projectName = Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Text(
        name,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 15.0,
          fontWeight: FontWeight.w900,
        ),
      ),
    );

    final infoIni = Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Text(
        begin.toString(),
        textAlign: TextAlign.left,
        style:
            TextStyle(fontFamily: "Lato", fontSize: 15.0, color: Colors.indigo),
      ),
    );

    final infoEnd = Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Text(
        end.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 15.0,
          color: Colors.indigo,
        ),
      ),
    );

    final userDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[projectName, infoIni, infoEnd],
    );

    final photo = Container(
      margin: EdgeInsets.only(top: 20.0, left: 20.0),
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(pathImage))),
    );

    return Row(
      children: <Widget>[photo, userDetails],
    );
  }
}
