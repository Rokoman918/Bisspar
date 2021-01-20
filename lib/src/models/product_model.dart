import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    String id;
    String nombre    ;
    double valor     ;
    bool disponible  ;
    String urlPhoto; 

    ProductModel({
        this.id,
        this.nombre = '',
        this.valor = 0.0,
        this.disponible = true,
        this.urlPhoto,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id         : json["id"],
        nombre     : json["nombre"],
        valor      : json["valor"].toDouble(),
        disponible : json["disponible"],
        urlPhoto   : json["urlPhoto"],
    );

    Map<String, dynamic> toJson() => {
        //"id"        : id,
        "nombre"    : nombre,
        "valor"     : valor,
        "disponible": disponible,
        "urlPhoto"  : urlPhoto,
    };
}
