import 'package:flutter/material.dart';
import 'package:poo_web/pages/pacientes/pacientesPerfil.dart';
import 'package:poo_web/pages/usuarios/home.dart';
import 'package:poo_web/pages/usuarios/planesDentales.dart';

import 'pages/pacientes/homePacientes.dart';
import 'pages/personal/personalPerfil.dart';


void main() {
  runApp(MyApp());
}

double maxWidth = 0;
double maxHeight = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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