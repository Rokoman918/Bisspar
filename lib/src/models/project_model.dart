import 'dart:convert';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
    int id;
    String nombre;
    int idCliente;
    String descripcion;
    String imagenUrl;
    String mensaje;  
    bool error;  
    

    Project({
       this.id,
        this.nombre      = '',
        this.idCliente   = 0,
        this.descripcion = '',
        this.imagenUrl   = '',
        this.mensaje     = '',
        this.error       = false,
    });

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        nombre      : json["nombre"],
        idCliente   : json["idCliente"],
        descripcion : json["descripción"],
        imagenUrl   : json["imagenUrl"],
        mensaje     : json["mensaje"],
        error       : json["error"],
    );

    Map<String, dynamic> toJson() => {
        "id"            : id,
        "nombre"        : nombre,
        "idCliente"     : idCliente,
        "descripción"   : descripcion,
        "imagenUrl"     : imagenUrl,
        "mensaje"       : mensaje,
        "error"         : error,
    };
}
