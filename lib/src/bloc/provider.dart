import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/login_bloc.dart';
export 'package:formvalidation/src/bloc/login_bloc.dart';

import 'package:formvalidation/src/pages/manage_time/bloc/project_bloc.dart';
import 'package:formvalidation/src/pages/manage_time/bloc/time_bloc.dart';
export 'package:formvalidation/src/pages/manage_time/bloc/project_bloc.dart';



class ProviderInheritedWidget extends InheritedWidget {
  static ProviderInheritedWidget _instancia;


  ProviderInheritedWidget._internal({Key key, Widget child})
      : super(key: key, child: child);


  factory ProviderInheritedWidget({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderInheritedWidget._internal(key: key, child: child);
    }

    return _instancia;
  }

  final loginBloc = LoginBloc();
  final projectBloc = ProjectBloc();
  final timesBloc = TimesBloc();
  

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc ofLogin(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProviderInheritedWidget)
            as ProviderInheritedWidget).loginBloc;
  }
  
  static ProjectBloc ofProject(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProviderInheritedWidget)
            as ProviderInheritedWidget).projectBloc;
  }

   static TimesBloc ofTimes(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProviderInheritedWidget)
            as ProviderInheritedWidget).timesBloc;
  }
}
