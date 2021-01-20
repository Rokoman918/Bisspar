import 'package:flutter/material.dart';


class DescriptionProject extends StatelessWidget {

  String nameProject;
  int starsNumber;
  String descriptionPrpject;
  int idProject;

  DescriptionProject(this.nameProject,  this.descriptionPrpject, this.idProject);

   @override
  Widget build(BuildContext context) {
   
    final title_stars = Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top:335.0, left: 20.0, right: 20.0), //Margin
          child: Text(
            nameProject,
            style: TextStyle(
                fontFamily:"Open",
                fontSize: 30.0,
                fontWeight: FontWeight.w900), //TextStyle
                textAlign: TextAlign.left,
          ),
        ),
       

      ],
    );
    final description = Container(
        margin: new EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      child: new Text(
        descriptionPrpject,
        style: const TextStyle(
           fontSize:16.0,
            fontWeight: FontWeight.bold,
          fontFamily:"Lato",
          color: Color(0xFF56575a) ) ,),);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        title_stars,
        description,
       //ProductPage() 


      ],
    ) ;
  }
}
