import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/manage_cost/ui/screens/manage_cost.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'bisspar_cupertino.dart';

void main() => runApp(MyApp());
const PrimaryColor = const Color(0xFF584CD1);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderInheritedWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestión Pro',
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => GestionProCupertino(),
          //'product':( BuildContext context ) => TimePage(),
          'cost': (BuildContext context) => ManageCost(),
        },
        theme: ThemeData(
          primaryColor: PrimaryColor,
        ),
      ),
    );
  }
}
