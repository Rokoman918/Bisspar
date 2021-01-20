import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/providers/product_provider.dart';


class HomePage extends StatelessWidget {


  final productProvider = new ProductProvider();
 


  @override
  Widget build(BuildContext context) {

   // final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton( context ),
            );
          }
      

Widget _crearListado(){

  return FutureBuilder(
    future: productProvider.cargarProductos() ,
    builder: (BuildContext context, AsyncSnapshot <List<ProductModel>>snapshot ) {
      if(snapshot.hasData)
      {

        final productos = snapshot.data;

        return ListView.builder(
          itemCount: productos.length,
          itemBuilder: (context , i)=>  _crearItem(context, productos[i]), 

        ) ;
      }else{

       return Center(child: CircularProgressIndicator());  
      }
      
    },
    )  ;
}

Widget  _crearItem( BuildContext context , ProductModel producto){

  return Dismissible(
    key:UniqueKey(),
    background: Container(
      color:Colors.deepPurpleAccent,
    ),
    onDismissed: (direcccion){
     productProvider.borrarProducto(producto.id);
    },
    child: Card(
      child: Column(
        children: <Widget>[
          (producto.urlPhoto == null)
          ?Image(image: AssetImage('assets/no-image.png'))
          :FadeInImage(
            image: NetworkImage(producto.urlPhoto),
            placeholder: AssetImage('assets/loading.gif'),
            height: 300.0,
            width: double.infinity ,
            fit:BoxFit.cover,
          ),
           ListTile(
      title: Text('${producto.nombre} - ${producto.valor}'),
      subtitle: Text(producto.id),
      onTap: () => Navigator.pushNamed(context, 'product', arguments: producto)
    ),
        ],

      ),
    ),

  );
}


 _crearBoton(BuildContext context) {
   return FloatingActionButton (
     child:  Icon(Icons.add),
     backgroundColor: Colors.deepPurple,
     onPressed: () => Navigator.pushNamed(context, 'product'),
   );
}



}