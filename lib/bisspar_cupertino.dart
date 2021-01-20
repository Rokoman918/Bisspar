
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/pages/manage_users/ui/screens/manage_users.dart';

import 'src/pages/manage_cost/ui/screens/manage_cost.dart';
import 'src/pages/manage_time/ui/screens/manage_times.dart';

class GestionProCupertino  extends StatelessWidget{

 
  @override
  Widget build(BuildContext context) {

    return Scaffold (
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time, color: Colors.indigo,),
              title: Text("Tiempos",
                      style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 15.0,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold
                  ),)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on, color: Colors.indigo,),
                title: Text("Costos",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 15.0,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold
                  ),)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.indigo,),
                title: Text("Perfil",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 15.0,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold
                  ),)
            ),
          ],
        ),

        tabBuilder: (BuildContext context, int index){
          switch(index){
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context)=>ManageTimes(),
              );
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context)=>ManageCost(),
              );
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context)=>ManageUsers(),
              );
              break;
          }
        },
      ),

    );
  }

}