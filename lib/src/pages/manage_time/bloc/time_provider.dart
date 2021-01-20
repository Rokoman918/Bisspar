import 'package:flutter/material.dart';
import 'project_bloc.dart';
export 'project_bloc.dart';


//Monitrear si se puede elimianr se unifico con  Provider InheritedWidget

class ProviderProject extends InheritedWidget {
  static ProviderProject _instancia;

  factory ProviderProject({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderProject._internal(key: key, child: child);
    }

    return _instancia;
  }

  ProviderProject._internal({Key key, Widget child})
      : super(key: key, child: child);

  final projectBloc = ProjectBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ProjectBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProviderProject)
            as ProviderProject)
        .projectBloc;

    /*  return context.dependOnInheritedWidgetOfExactType<ProviderProjectBloc>().manageProjectBloc;*/
  }
}
