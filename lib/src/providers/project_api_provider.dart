import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/project_model.dart';
import 'dart:async';
import 'package:formvalidation/src/pages/manage_time/bloc/project_bloc.dart';

class ProjectApiProvider {
  final String _urlBase = 'https://apibisspardev.azurewebsites.net';

  List<Project> _listProjects = new List();
  //ProjectBloc projectBloc = new ProjectBloc();

  Future<List<Project>> getProjects(
      ProjectBloc projectBloc, int idCustomer) async {
    final url = '$_urlBase/GetProject/$idCustomer';
    final response = await _processResponse(url);
    _listProjects.addAll(response);
    projectBloc.projectsSink(_listProjects);
    return response;
  }

  Future<List<Project>> _processResponse(String url) async {
    final resp = await http.get(url);
    final List<dynamic> decodeData = json.decode(resp.body);
    final List<Project> listaProjects = new List();

    if (decodeData == null) return [];

    print(decodeData);

    decodeData.forEach((proj) {
      final projTemp = Project.fromJson(proj);
      projTemp.id = int.parse(proj['id'].toString());
      projTemp.nombre = proj['nombre'].toString();
      projTemp.descripcion = proj['descripcion'].toString();
      projTemp.imagenUrl = proj['imagenUrl'].toString();

      listaProjects.add(projTemp);
    });
    print(listaProjects);
    return listaProjects;
  }
}
