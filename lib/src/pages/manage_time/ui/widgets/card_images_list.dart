import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/project_model.dart';

import 'package:formvalidation/src/pages/manage_time/bloc/time_provider.dart';
import 'package:formvalidation/src/pages/manage_time/ui/widgets/description_project.dart';

import 'package:formvalidation/src/providers/project_api_provider.dart';
import 'card_images.dart';

class CardImageList extends StatefulWidget {
  @override
  _CardImageListState createState() => _CardImageListState();
}


class _CardImageListState extends State<CardImageList> {
  
  DescriptionProject despro = new DescriptionProject("", "", 0);
  //final ProjectBloc _projectBloc = new ProjectBloc();
  List<Project> listP = new List<Project>();
  IconData iconData = Icons.favorite_border;
  ProjectApiProvider _apiProvider = new ProjectApiProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = ProviderInheritedWidget.ofProject(context);
     _apiProvider.getProjects(bloc, 4017);//TODO Cambiar codigo cliente 4017 por un metodo que lo traiga al ingresar usuario y contraseña
    return Container(
        height: 350.0, //Marca el alto de las cards de proyectos
        child: StreamBuilder(
            stream: bloc.projectsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return listViewProjects(
                    buildCardImagesProject(bloc, context, snapshot.data));
              } else {               
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget listViewProjects(List<CardImageWithFabIcon> projectCard) {
    return ListView(
      padding: EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: projectCard,
    );
  }

  Widget _crearItem(BuildContext context, Project proyecto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.deepPurpleAccent,
      ),
      onDismissed: (direcccion) {
        //productProvider.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (proyecto.imagenUrl == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    image: NetworkImage(proyecto.imagenUrl),
                    placeholder: AssetImage('assets/loading.gif'),
                    height: 180.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
                title: Text('${proyecto.nombre} - ${proyecto.descripcion}'),
                subtitle: Text(proyecto.id.toString()),
                onTap: () =>
                    Navigator.pushNamed(context, 'product', arguments: "")),
          ],
        ),
      ),
    );
  }

  List<CardImageWithFabIcon> buildCardImagesProject(ProjectBloc mpb,
      BuildContext context, List<Project> projectSnapShot) {
    List<CardImageWithFabIcon> projectsCard = List<CardImageWithFabIcon>();
    double width = 240.0;
    double height = 210.0;
    double left = 20.0;
    double top = 80.0;
    String namePro = "";
    String desPro = "";
    int idPro = 0;

    projectSnapShot.forEach((f) {
      projectsCard.add(CardImageWithFabIcon(
        height: height,
        width: width,
        pathImage: f.imagenUrl,
        left: left,
        top: top,
        idProject: f.id,
        nameProject: '${f.descripcion}\n${f.nombre}',
        // descripProject: f.descripcion,
        onPressedFabIcon: () {
          _showProject(mpb, context, f);
        },
        iconData: iconData,
      ));
    });
    return projectsCard;
  }

  _showProject(ProjectBloc mpb, BuildContext context, Project p) {
    mpb.changeNameProject(p.nombre);
    mpb.changeDescriptionProject(p.descripcion);
    mpb.changeIdProject(p.id);

    mpb.changeAloneProject(p);

    despro.descriptionPrpject = p.descripcion;
    despro.nameProject = p.nombre;
    despro.idProject = p.id;
    if (iconData == Icons.favorite_border) {
      iconData = _returnIconData(true);
    } else {
      iconData = _returnIconData(false);
    }
    setState(() {});

    //place.liked = !place.liked;
    //setState(() {});
  }

  IconData _returnIconData(bool like) {
    return like ? Icons.favorite : Icons.favorite_border;
  }
}

/*switch (snapshot.connectionState){
                              case ConnectionState.waiting:
                                return Center(child:CircularProgressIndicator());
                                
                              case ConnectionState.none:
                                  return Center(child: CircularProgressIndicator());
                                  
                              case ConnectionState.active:
                                return listViewProjects( buildCardImagesProject(snapshot.data));
                                
                              case ConnectionState.done:
                                return listViewProjects( buildCardImagesProject(snapshot.data));
                             
                            }
                             */
