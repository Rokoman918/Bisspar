import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/manage_time/bloc/time_bloc.dart';
import 'package:formvalidation/src/pages/manage_time/model/history_record_model.dart';
import 'package:formvalidation/src/pages/manage_time/ui/widgets/historical_record.dart';

import 'package:formvalidation/src/providers/time_api_provider.dart';

class HistoricalRecordList extends StatefulWidget {
  @override
  _HistoricalRecordListState createState() => _HistoricalRecordListState();
}

class _HistoricalRecordListState extends State<HistoricalRecordList> {
  TimeApiProvider _apiProvider = new TimeApiProvider();

  @override
  Widget build(BuildContext context) {
    final blocProj = ProviderInheritedWidget.ofProject(context);
    final blocTime = ProviderInheritedWidget.ofTimes(context);

//TODO: quitar el codigo quemado del usuario tomrlo del login o no se de donde
    _apiProvider.getHistorycalRecord(blocProj, blocTime, 162);

    return Container(
      child: StreamBuilder(
          stream: blocTime.historycalRecordStream,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              //return Column(
              //  crossAxisAlignment: CrossAxisAlignment.start,
              //  children: <Widget>[

              //  new HistoricalRecord("assets/Rodri.png", "Control Acceso Colciencias","Entrada 7:45", "Salida     10:45"),
              //  new HistoricalRecord("assets/Rodri.png",  "CCTV Hotel Dann","Entrada 10:46", "Salida     14:00"),
              //  new HistoricalRecord("assets/Rodri.png", "Oficina Principal", "Entrada 14:01", "Salida    - Sin Dato" ),
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listViewHistory(buildCardHistoricalRecords(
                    blocTime, context, snapshot.data)),
              );
              // ],
              // );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  List<Widget> listViewHistory(List<HistoricalRecord> historyRecorded) {
    List<Widget> records = [];

    records = buildCardHistoricalRecord(historyRecorded);

    return records;
  }

  List<Widget> buildCardHistoricalRecord(
      List<HistoricalRecord> historyRecorded) {
    List<HistoricalRecord> historycalCard = List<HistoricalRecord>();

    for (var item in historyRecorded) {
      historycalCard.add(
          HistoricalRecord(item.pathImage, item.name, item.begin, item.end));
    }

    return historycalCard;
  }

  List<HistoricalRecord> buildCardHistoricalRecords(TimesBloc mpb,
      BuildContext context, List<HistoryRecordModel> historySnapShot) {
    List<HistoricalRecord> historycalCard = List<HistoricalRecord>();
    double width = 240.0;
    double height = 150.0;
    double left = 20.0;
    double top = 80.0;
    String name = "";
    String end = "";
    String begin = "";
    String pathImage = "";

    historySnapShot.forEach((f) {
      historycalCard.add(HistoricalRecord(
        f.rutaFotoEntrada,
        f.nombreProyectoEntrada.toString(),
        'Entrada: ' +
            DateTime.parse(f.fechaHoraEntrada).toLocal().hour.toString() +
            ':' +
            DateTime.parse(f.fechaHoraEntrada).minute.toString(),
        'Salida: ' +
            DateTime.parse(f.fechaHoraSalida).toLocal().hour.toString() +
            ':' +
            DateTime.parse(f.fechaHoraSalida).minute.toString(),
      ));
    });
    return historycalCard;
  }
}
