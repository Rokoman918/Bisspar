import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/attendense_model.dart';
import 'package:formvalidation/src/models/project_model.dart';

import 'package:formvalidation/src/pages/manage_time/ui/widgets/description_project.dart';
import 'package:formvalidation/src/pages/manage_time/ui/widgets/historical_record_list.dart';

import 'package:formvalidation/src/providers/time_api_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:intl/intl.dart';
import 'header.dart';
import 'package:geolocator/geolocator.dart';

class ManageTimes extends StatefulWidget {
  @override
  _ManageTimes createState() => _ManageTimes();
}

class _ManageTimes extends State<ManageTimes> {
  String projectDescription =
      'Para registrar tiempo en cada proyecto debe seleccionar uno de la lista de proyectos disponibles';
  String projectName = 'Seleccione Proyecto';
  int idProject = 0;
  final formKey = GlobalKey<FormState>();
  final scafolKey = GlobalKey<ScaffoldState>();
  //final productoProvider = new ProductProvider();
  final timeProvider = new TimeApiProvider();
  final double height_size = 100.0;
  final double width_size = 100.0;
  final width_texFormField = 150.0;
  final double borderRadius_circular = 10.0;
  static DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  AttendanceModel attendenceModel = new AttendanceModel();
  bool _guardando = false;
  File foto;
  Position position;
  List<Placemark> placemark;
  String gpsPositionLabel = "Calcular posición";
  String reg_respnse = DateFormat('yyyy-MM-dd hh:mm').format(now);
  bool changeProject = true;
  Project p;

  @override
  Widget build(BuildContext context) {
    final bloc = ProviderInheritedWidget.ofProject(context);

    return StreamBuilder(
        stream: bloc.aloneprojectStream,
        builder: (context, AsyncSnapshot snapshot) {
          p = snapshot.data;
          return Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  _showDescription(p),
                  _createFieldsAndPhoto(),
                  //_actualizarGPS(),
                  _responseAttendace(),
                  _crearChangeBoton(),
                  _LabelHistory(),
                  _LabelDate(),
                  HistoricalRecordList(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _responseAttendace(),
                  _crearOutBoton(),
                  SizedBox(
                    height: 50.0,
                  )
                  //ReviewList()
                ],
              ),
              HeaderAppbar(),
            ],
          );
        });
  }

  Widget _createFieldsAndPhoto() {
    return Row(
      children: <Widget>[_form(), _showPhoto()],
    );
  }

  Widget _form() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Form(key: formKey, child: _creteFields()),
    );
  }

  Widget _creteFields() {
    return Column(
      children: <Widget>[
        Container(
          width: width_texFormField,
          margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 10.0),
          child: TextFormField(
            //initialValue: productModel.valor.toString(),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: 'Código',
                labelText: 'Código Interno'),
            onSaved: (value) => attendenceModel.idPersona = int.parse(value),
            validator: (value) {
              if (utils.isNumeric(value)) {
                return null;
              } else {
                return 'Ingrese Sólo Números';
              }
            },
          ),
        ),
        Container(
          width: width_texFormField,
          margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 10.0),
          child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              //initialValue: productModel.nombre,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Pin',
                  labelText: 'Pin Secreto'),
              onSaved: (value) => attendenceModel.pin = value,
              validator: (value) {
                if (value.length < 2) {
                  return 'Ingrese su Pin secreto';
                } else {
                  return null;
                }
              }),
        )
      ],
    );
  }

  Widget _crearChangeBoton() {
    changeProject = false; // Marca una salida  en el evento _onSubmit
    return Container(
      margin: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
      child: RaisedButton.icon(
        key: (UniqueKey()),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed: (_guardando) ? null : setMethodChageProject,
        icon: Icon(Icons.transfer_within_a_station),
        label: Text('Trabajar en un Proyecto'),
      ),
    );
  }

  Widget _crearOutBoton() {
    return Container(
      margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
      child: RaisedButton.icon(
        key: (UniqueKey()),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.pink,
        textColor: Colors.white,
        onPressed: (_guardando) ? null : setMethodEndWork,
        icon: Icon(Icons.hotel),
        label: Text('Finalizar Jornada'),
      ),
    );
  }

  VoidCallback setMethodChageProject() {
    changeProject = false;
    if (p == null) {
      _showAlertDialog(context, "Indique un Proyecto", "",
          "¿A que proyecto le va a trabajar?", "Seleccionar uno");
      return null;
    } else {
      _showAlertDialogConfirm(
          context, "¿Quiere Registrar en?", p.nombre, p.descripcion);
    }
    return _onSubmit(this.context, p);
  }

  VoidCallback setMethodEndWork() {
    changeProject = true;
    return _onSubmit(this.context, p);
  }

  _onSubmit(BuildContext context, Project p) async {
    try {
      //Calculando la posición
      if (gpsPositionLabel == "Calcular posición" || gpsPositionLabel == null) {
        //await getLocation();
        await _getLocationChange();
      }

      //Cargando los  datos basicos a ser guardados en el modelo
      attendenceModel.puntoControl = "Registro móvil";
      _updateHour();

      attendenceModel.idProyecto = p.id;

      //Procesando la  carga de la foto
      if (foto != null) {
        //TODO  Activar la carga de la foto
        //attendenceModel.rutaFoto  = await timeProvider.subirImagen(foto);
      }

      attendenceModel.rutaFoto = "http://...";
      attendenceModel.altitud = 0;

      //Activamos la validacion de formulario
      if (!formKey.currentState.validate()) return;

      //Activamos el onsave de los txtformfield dentro del formulario
      formKey.currentState.save();

      setState(() {
        _guardando = true;
        _updateHour();
      });

      if (changeProject) {
        // Registra una entrada O salida
        await timeProvider.setAttendance(attendenceModel).then((onValue) {
          setState(() {
            reg_respnse = onValue;
          });
        }).catchError((error) => print(error));
      } else {
        // registra un cambio de preyocto Salida Y entrada
        await timeProvider.changeProject(attendenceModel).then((onValue) {
          setState(() {
            reg_respnse = onValue;
          });
        }).catchError((error) => print(error));
      }
      //Navigator.pop(context);
      setState(() {
        _guardando = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _actualizarGPS() {
    return SwitchListTile(
      value: false,
      title: Text(gpsPositionLabel),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        //getLocation();
        if (value == false) {
          gpsPositionLabel = "Desconocido";
        } else {
          _getLocationChange();
        }
      }),
    );
  }

  Widget _responseAttendace() {
    return Text(
      reg_respnse,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.deepPurple[400],
        fontSize: 20.0,
      ),
    );
  }

  Future<List<Placemark>> getLocation() async {
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    attendenceModel.longitud = position.longitude;
    attendenceModel.latitud = position.latitude;
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    attendenceModel.observacionRegistro =
        '${placemark[0].locality} ${placemark[0].country} ${placemark[0].subLocality} ${placemark[0].thoroughfare} ${placemark[0].subThoroughfare}';
    gpsPositionLabel = attendenceModel.observacionRegistro.trim();
    return placemark;
  }

  Future<List<Placemark>> _getLocationChange() async {
    List<Placemark> placemark;

    try {
      Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
      LocationOptions locationOptions =
          LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
      //Validar si los permsos estan otorgados
      GeolocationStatus geolocationStatus =
          await Geolocator().checkGeolocationPermissionStatus();

      if (geolocationStatus.value != 2) {
        print("GPS apagado");
      }
      StreamSubscription<Position> positionStream = geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) async {
        print(position == null
            ? 'Unknown'
            : position.latitude.toString() +
                ', ' +
                position.longitude.toString());

        if (position != null) {
          attendenceModel.longitud = position.longitude;
          attendenceModel.latitud = position.latitude;
          placemark = await geolocator.placemarkFromCoordinates(
              position.latitude, position.longitude);
          attendenceModel.observacionRegistro =
              '${placemark[0].locality} ${placemark[0].country} ${placemark[0].subLocality} ${placemark[0].thoroughfare} ${placemark[0].subThoroughfare}';
          gpsPositionLabel = attendenceModel.observacionRegistro.trim();
        } else {
          gpsPositionLabel = "Posición Desconocida";
          attendenceModel.observacionRegistro = gpsPositionLabel.toString();
        }
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
    return placemark;
  }

  Widget _showPhoto() {
    if (foto != null) {
      return Material(
        child: InkWell(
          onTap: () {
            _tomarFoto();
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              shape: BoxShape.rectangle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black87,
                    blurRadius: 25.0,
                    offset: Offset(0.0, 10.0))
              ],
            ),
            child: Image.file(
              foto,
              height: height_size,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }

    return Material(
        child: InkWell(
      onTap: () {
        _tomarFoto();
        setState(() {});
      },
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset('assets/camera.png',
              width: width_size, height: height_size),
        ),
      ),
    ));

    // return Image.asset('assets/camera.png', height: height_Size ,width: width_Size , );
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      attendenceModel.rutaFoto = null;
    }

    setState(() {});
  }

  Widget _LabelHistory() {
    return Container(
      margin: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0, bottom: 0.0),
      child: Text('Historico de\nMarcaciones Hoy\n',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Lato", fontSize: 18.0, fontWeight: FontWeight.w900)),
    );
  }

  Widget _LabelDate() {
    return Container(
      alignment: AlignmentDirectional.bottomCenter,
      child: Text('(${formattedDate.toString()})',
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontFamily: "Lato", fontSize: 12.0, fontWeight: FontWeight.w900)),
    );
  }

  void _updateHour() {
    now = DateTime.now();
    reg_respnse = DateFormat('yyyy-MM-dd hh:mm').format(now);
    attendenceModel.fechaHoraRegistro = now;
  }

  Widget _showDescription(Project p) {
    _getLocationChange();
    if (p != null) {
      return DescriptionProject(p.nombre, p.descripcion, p.id);
    } else {
      return DescriptionProject(projectName, projectDescription, idProject);
    }
  }

  Future<void> _showAlertDialog(BuildContext context, String title,
      String text1, String text2, String btntext) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text1),
                Text(text2),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(btntext),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAlertDialogConfirm(
      BuildContext context, String title, String text1, String text2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  text1,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                Text(
                  text2,
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.yellow),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 24.0,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Si",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white)),
              onPressed: () {
                _onSubmit(context, p);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Quiero cambiarlo",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
