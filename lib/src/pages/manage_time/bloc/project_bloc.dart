import 'dart:async';
import 'package:formvalidation/src/models/project_model.dart';
import 'package:rxdart/rxdart.dart';

class ProjectBloc {

//================================================================================================================================= Lista de Proyectos
  final _projectsStreamController           = StreamController<List<Project>>.broadcast();
  Function(List<Project>) get projectsSink  => _projectsStreamController.sink.add;
  Stream<List<Project>> get projectsStream  => _projectsStreamController.stream;
//================================================================================================================================= Solo un Proyecto
  final _aloneProjectController             = StreamController<Project>.broadcast();
  Stream<Project> get aloneprojectStream    => _aloneProjectController.stream;      //Recuperar los datos del stream
  Function(Project) get changeAloneProject  => _aloneProjectController.sink.add;  //Insertar Valores en el Stream
//=================================================================================================================================  Propieddad Nameproject
  final _nameprojectController            = BehaviorSubject<String>();    
  Stream<String> get nameProjectStream    => _nameprojectController.stream;      //Recuperar los datos del stream
  Function(String) get changeNameProject  => _nameprojectController.sink.add;  //Insertar Valores en el Stream
  String get nameProject                  => _nameprojectController.value;                  // Obtener el último valor ingresado a los streams
//================================================================================================================================= Propiedad DescriptionProject
  final _descriptionProjectController           = BehaviorSubject<String>();
  Stream<String> get descriptionProjectStream   => _descriptionProjectController.stream;
  Function(String) get changeDescriptionProject => _descriptionProjectController.sink.add;
  String get  descriptionProject                => _descriptionProjectController.value;
//================================================================================================================================= Propiedad IdProject
  final _idProjectController        = BehaviorSubject<int>();
  Stream<int> get idProjectStream   => _idProjectController.stream;
  Function(int) get changeIdProject => _idProjectController.sink.add;
  int get idProject                 => _idProjectController.value;   
//=================================================================================================================================

  dispose() {
      _nameprojectController?.close();
      _descriptionProjectController?.close();
      _idProjectController?.close();
      _projectsStreamController?.close();
      _aloneProjectController?.close();
    }
}
