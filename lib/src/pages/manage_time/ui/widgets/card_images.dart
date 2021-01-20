import 'package:flutter/material.dart';

import 'floating_action_button_green.dart';

class CardImageWithFabIcon extends StatelessWidget {
  final double height;
  final double width;
  final double left;
  final double top;
  final String pathImage;
  final int idProject;
  final String nameProject;
  final String descripProject;
  final VoidCallback onPressedFabIcon;
  final IconData iconData;


  CardImageWithFabIcon({
    Key key,
    @required this.pathImage,
    @required this.width,
    @required this.height,
    @required this.onPressedFabIcon,
    @required this.iconData,
    @required this.idProject,
    @required this.nameProject,
    @required this.descripProject,
    this.left,
    this.top,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final card = Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(left: left, top: top),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, 
                image: NetworkImage(pathImage)),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            shape: BoxShape.rectangle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 9.0))
            ]),
        child: Text(nameProject,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: "Lato",
                fontWeight: FontWeight.normal)),
        alignment: Alignment(-0.9, -0.96));

    return Stack(
      alignment: Alignment(0.9, 1.1),
      children: <Widget>[
        card,
        FloatingActionButtonGreen(
          iconData: iconData,
          onPressed: onPressedFabIcon,
        )
      ],
    );
  }
}
