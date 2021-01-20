import 'package:flutter/material.dart';

class GradientBack   extends StatelessWidget{

  String title = "Popular";
  String PathImage = "logo.PNG";

  GradientBack (this.title, this.PathImage);

  @override
  Widget build(BuildContext context) {
    
    return Container(

      height: 250.0,
      decoration:  BoxDecoration(

        image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(PathImage)
        ),

        gradient: LinearGradient(
          colors: [
            Color(0xFF4268D3),
            Color(0xFF584CD1)
          ],
          begin: FractionalOffset(0.2,0.0),
          end: FractionalOffset(1.0, 0.6),
            stops: [0.0,0.6],
            tileMode: TileMode.clamp
        )

      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
            fontFamily: "Lato",
            fontWeight: FontWeight.bold
        ),
      ),
      alignment: Alignment(-0.9,-0.6)
    );


  }
}