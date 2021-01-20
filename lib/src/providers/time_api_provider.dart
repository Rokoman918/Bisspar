import 'dart:convert';

import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/attendense_model.dart';
import 'package:formvalidation/src/pages/manage_time/bloc/time_bloc.dart';
import 'package:formvalidation/src/pages/manage_time/model/history_record_model.dart';
import 'package:http/http.dart' as http;

class TimeApiProvider {
  final String _urlBase = 'https://apibisspardev.azurewebsites.net';

  String _response = "";

  Future<String> setAttendance(AttendanceModel _attendence) async {
    final url = '$_urlBase/SetAttendance';
    final response = await _processResponse(url, _attendence);
    print(response);
    _response = response;
    return response;
  }

  Future<String> changeProject(AttendanceModel _attendence) async {
    final url = '$_urlBase/ChangeProject';
    final response = await _processResponse(url, _attendence);
    print(response);

    return response;
  }

  Future<String> _processResponse(String url, AttendanceModel att) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = attendanceToJson(att);
    final resp = await http.post(url, headers: headers, body: jsonBody);
    // check the status code for the result
    int statusCode = resp.statusCode;
    final String decodeData = resp.body;
    if (decodeData == null) return "No hubo respuesta";
    print(decodeData);
    return decodeData;
  }

  Future<List<HistoryRecordModel>> getHistorycalRecord(
      ProjectBloc projectBloc, TimesBloc timeBloc, int idPersona) async {
    final url = '$_urlBase/GetCurrentHistoryRecords/$idPersona';
    final response = await _processResponseGet(url);
    timeBloc.historycalRecordSink(response);
    return response;
  }

  Future<List<HistoryRecordModel>> _processResponseGet(String url) async {
    final resp = await http.get(url);
    final List<dynamic> decodeData = json.decode(resp.body);
    final List<HistoryRecordModel> historycalRecords = new List();

    if (decodeData == null) return [];

    print(decodeData);

    decodeData.forEach((hist) {
      final histoTemp = HistoryRecordModel.fromJson(hist);
      histoTemp.idPersona = int.parse(hist['idPersona'].toString());
      histoTemp.idProyectoEntrada =
          int.parse(hist['idProyectoEntrada'].toString());
      histoTemp.idProyectoSalida =
          int.parse(hist['idProyectoSalida'].toString());
      histoTemp.rutaFotoEntrada = hist['rutaFotoEntrada'].toString();
      histoTemp.rutaFotoSalida = hist['rutaFotoSalida'].toString();
      //histoTemp.fechaHoraEntrada = DateTime.parse(hist['fechaHoraEntrada'].toString());
      //histoTemp.fechaHoraSalida = DateTime.parse(hist['fechaHoraSalida'].toString());
      histoTemp.fechaHoraEntrada = hist['fechaHoraEntrada'].toString();
      histoTemp.fechaHoraSalida = hist['fechaHoraSalida'].toString();
      histoTemp.nombreProyectoEntrada =
          hist['nombreProyectoEntrada'].toString();
      historycalRecords.add(histoTemp);
    });
    print(historycalRecords);
    return historycalRecords;
  }
}
