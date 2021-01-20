import 'package:flutter/material.dart';
import 'package:poo_web/pages/pacientes/maqueta.dart';

import 'pages/pacientes/homePacientes.dart';


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
      home: Maqueta(),
      routes: <String, WidgetBuilder>{
      },
    );
  }
}