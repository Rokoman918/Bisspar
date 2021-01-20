import 'package:flutter/material.dart';
import 'package:formvalidation/src/page_components/gradient_back.dart';
import 'package:formvalidation/src/pages/manage_time/ui/widgets/card_images_list.dart';

class HeaderAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GradientBack("Proyectos Disponibles", "assets/logo.jpg"),
        CardImageList()
      ],
    );
  }
}
