import 'dart:convert';

HistoryRecordModel historyRecordModelFromJson(String str) =>
    HistoryRecordModel.fromJson(json.decode(str));

String historyRecordModelToJson(HistoryRecordModel data) =>
    json.encode(data.toJson());

class HistoryRecordModel {
  int idPersona;
  //DateTime fechaHoraEntrada;
  //DateTime fechaHoraSalida;
  String fechaHoraEntrada;
  String fechaHoraSalida;
  int idEmpresaEntrada;
  int idSucursalEntrada;
  String rutaFotoEntrada;
  String rutaFotoSalida;
  String observacionEntrada;
  String observacionSalida;
  int idProyectoEntrada;
  int idProyectoSalida;
  String nombreProyectoEntrada;

  HistoryRecordModel({
    this.idPersona,
    this.fechaHoraEntrada,
    this.fechaHoraSalida,
    this.idEmpresaEntrada,
    this.idSucursalEntrada,
    this.rutaFotoEntrada,
    this.rutaFotoSalida,
    this.observacionEntrada,
    this.observacionSalida,
    this.idProyectoEntrada,
    this.idProyectoSalida,
    this.nombreProyectoEntrada,
  });

  factory HistoryRecordModel.fromJson(Map<String, dynamic> json) =>
      HistoryRecordModel(
        idPersona: json["idPersona"],
        //fechaHoraEntrada: DateTime.parse(json["fechaHoraEntrada"]).toLocal(),
        //fechaHoraSalida:  DateTime.parse(json["fechaHoraSalida"]).toLocal() ,
        fechaHoraEntrada:
            DateTime.parse(json["fechaHoraEntrada"]).toLocal().hour.toString(),
        fechaHoraSalida:
            DateTime.parse(json["fechaHoraSalida"]).toLocal().hour.toString(),

        idEmpresaEntrada: json["idEmpresaEntrada"],
        idSucursalEntrada: json["idSucursalEntrada"],
        rutaFotoEntrada: json["rutaFotoEntrada"],
        rutaFotoSalida: json["rutaFotoSalida"],
        observacionEntrada: json["observacionEntrada"],
        observacionSalida: json["observacionSalida"],
        idProyectoEntrada: json["idProyectoEntrada"],
        idProyectoSalida: json["idProyectoSalida"],
        nombreProyectoEntrada: json["nombreProyectoEntrada"],
      );

  Map<String, dynamic> toJson() => {
        "idPersona": idPersona,
        "fechaHoraEntrada": fechaHoraEntrada,
        "fechaHoraSalida": fechaHoraSalida,
        "idEmpresaEntrada": idEmpresaEntrada,
        "idSucursalEntrada": idSucursalEntrada,
        "rutaFotoEntrada": rutaFotoEntrada,
        "rutaFotoSalida": rutaFotoSalida,
        "observacionEntrada": observacionEntrada,
        "observacionSalida": observacionSalida,
        "idProyectoEntrada": idProyectoEntrada,
        "idProyectoSalida": idProyectoSalida,
        "nombreProyectoEntrada": nombreProyectoEntrada,
      };
}
