import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poo_web/myWidgets.dart';
import 'package:poo_web/mystyle.dart';

import '../datos.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    obtenerPlanes();
    obtenerEspecialidades();

    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;

    double width = sW > maxScreenSize ? sW : maxScreenSize;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: new Size.fromHeight(sizeAppBar),
        child: MyRAppBar(tipo: rolGlobal)
      ),
      body: MyRHome(),
    );
  }
}