import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/floating_action_button_green.dart';


class CardImages extends StatelessWidget{

  String PathImage = "=Oficina3.PNG";
  String NameProject = "Nombre Del proyecto";
  CardImages(this.PathImage, this.NameProject);

  @override
  Widget build(BuildContext context) {
  
    final card = Container(
      height: 380.0,
      width: 200.0,
      margin: EdgeInsets.only(
        top: 30.0,
        left: 20.0
      ),
      decoration: BoxDecoration(
       image: DecorationImage(
         fit: BoxFit.cover,
         image: AssetImage(PathImage)

       ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow:<BoxShadow>[
          BoxShadow(
          color: Colors.black38,
          blurRadius: 15.0,
          offset: Offset(0.0,7.0)
        )
        ]
      ),
        child: Text(
        NameProject,
        style: TextStyle(
        color: Colors.white,
        fontSize: 15.0,
        fontFamily: "Lato",
        fontWeight: FontWeight.bold
        )
        ),
        alignment: Alignment(-0.9,-0.96)

    );

    return Stack(
      alignment: Alignment(0.9,1.1),
      children: <Widget>[
      card,
      //FloatingActionButtonGreeen(),
      ],
    );
  }


}