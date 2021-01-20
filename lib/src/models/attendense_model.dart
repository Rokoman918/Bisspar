import 'dart:convert';

AttendanceModel attendanceFromJson(String str) => AttendanceModel.fromJson(json.decode(str));

String attendanceToJson(AttendanceModel data) => json.encode(data.toJson());

class AttendanceModel {
    int idPersona;
    String pin;
    DateTime fechaHoraRegistro;
    String observacionRegistro;
    String puntoControl;
    String rutaFoto;
    double longitud;
    double latitud;
    int altitud;
    int idProyecto;

    AttendanceModel({
        this.idPersona,
        this.pin,
        this.fechaHoraRegistro,
        this.observacionRegistro,
        this.puntoControl,
        this.rutaFoto,
        this.longitud,
        this.latitud,
        this.altitud,
        this.idProyecto,
    });

    factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
        idPersona: json["IdPersona"],
        pin: json["PIN"],
        fechaHoraRegistro: DateTime.parse(json["FechaHoraRegistro"]),
        observacionRegistro: json["ObservacionRegistro"],
        puntoControl: json["PuntoControl"],
        rutaFoto: json["RutaFoto"],
        longitud: json["Longitud"].toDouble(),
        latitud: json["Latitud"].toDouble(),
        altitud: json["Altitud"],
        idProyecto: json["IdProyecto"],
    );

    Map<String, dynamic> toJson() => {
        "IdPersona": idPersona,
        "PIN": pin,
        "FechaHoraRegistro": fechaHoraRegistro.toIso8601String(),
        "ObservacionRegistro": observacionRegistro,
        "PuntoControl": puntoControl,
        "RutaFoto": rutaFoto,
        "Longitud": longitud,
        "Latitud": latitud,
        "Altitud": altitud,
        "IdProyecto": idProyecto,
    };
}
