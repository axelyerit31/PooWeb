import 'package:flutter/material.dart';
import 'package:poo_web/pages/pacientes/pacientesPerfil.dart';

import '../../mystyle.dart';
import 'package:poo_web/myWidgets.dart';

import '../maquetaPerfil.dart';

class HomePacientes extends StatefulWidget {

  @override
  _HomePacientesState createState() => _HomePacientesState();
}

class _HomePacientesState extends State<HomePacientes> {
  @override
  Widget build(BuildContext context) {

    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;

    double width = sW > maxScreenSize ? sW : maxScreenSize;

    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: new Size.fromHeight(sizeAppBar),
        child: MyRAppBar(
          tipo: "usuarios",
          myRoute: PacientesPerfil()
        )
      ),
      body: MyRHome(),
    );
  }
}