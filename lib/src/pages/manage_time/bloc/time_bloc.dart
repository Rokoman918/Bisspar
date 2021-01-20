
import 'dart:async';
import 'package:formvalidation/src/pages/manage_time/model/history_record_model.dart';

  
  class TimesBloc {

//================================================================================================================================= Lista de Proyectos
  final _historycalRecordStreamController           = StreamController<List<HistoryRecordModel>>.broadcast();
  Function(List<HistoryRecordModel>) get historycalRecordSink  => _historycalRecordStreamController.sink.add;
  Stream<List<HistoryRecordModel>> get historycalRecordStream  => _historycalRecordStreamController.stream;
//================================================================================================================================= Solo un Proyecto

 dispose() {
      _historycalRecordStreamController?.close();     
    }
  }