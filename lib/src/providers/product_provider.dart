
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:formvalidation/src/models/product_model.dart';

import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';


class ProductProvider{

  final String _urlBase = 'https://gestionpro-b6483.firebaseio.com';



  Future<bool> crearProducto(ProductModel producto) async {

    final url = '$_urlBase/productos.json';
    final resp = await http.post(url, body: productModelToJson(producto)) ;

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;

  }

  Future<List<ProductModel>>  cargarProductos() async{

    final url = '$_urlBase/productos.json';
    final resp = await http.get(url);    
    final Map<String,dynamic> decodeData = json.decode(resp.body);
    final List<ProductModel> listaProductos =new List();

    if(decodeData == null) return[];

    print( decodeData );

    decodeData.forEach( (id, prod){

      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;
      listaProductos.add(prodTemp);
      });
      print( listaProductos );
      return listaProductos;
  }

   Future<int>  borrarProducto(String id) async{

    final url = '$_urlBase/productos/$id.json';
    final resp = await http.delete(url);
    print (json.decode(resp.body));
    return 1;
  }




  Future<bool> editarProducto(ProductModel producto) async {

    final url = '$_urlBase/productos/${producto.id}.json';
    final resp = await http.put(url, body: productModelToJson(producto)) ;

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;

  }

 
Future<String> subirImagen(File imagen) async {
  
  final url = Uri.parse ('https://api.cloudinary.com/v1_1/dosnl-to-next-level/image/upload?upload_preset=qokky3iy');
  final mimeType = mime(imagen.path).splitMapJoin('/');
  final imageUploadRequest = http.MultipartRequest(
    'POST',
    url
  );

  final file= await http.MultipartFile.fromPath(
  'file', imagen.path,
  contentType: MediaType(mimeType[0], mimeType[1])

  );

  imageUploadRequest.files.add(file);

  final streamResponse = await imageUploadRequest.send();

  final resp = await http.Response.fromStream(streamResponse);

  if(resp.statusCode != 200 && resp.statusCode != 201){
    print('Algo Salio mal');
    print(resp.body);
    return null; 
  }

  final respData = json.decode(resp.body);
  print(respData);

  return respData['secure_url'];
   

}


}