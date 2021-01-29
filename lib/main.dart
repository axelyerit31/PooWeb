import 'package:flutter/material.dart';
import 'package:poo_web/pages/usuarios/home.dart';
import 'package:poo_web/pages/usuarios/planesDentales.dart';

import 'pages/usuarios/cita.dart';


void main() {
  runApp(MyApp());
}

double maxWidth = 0;
double maxHeight = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //obtenerPlanes();
    //obtenerEspecialidades();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Centro Dental Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}