import 'package:flutter/material.dart';
import 'package:poo_web/pages/datos.dart';

import '../../mystyle.dart';
import 'fichaPersonal.dart';

class Citas extends StatefulWidget {
  @override
  _CitasState createState() => _CitasState();
}

class _CitasState extends State<Citas> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        _citas()
      ],
    );
  }
}

Widget _header(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Hero(
        tag: "imagePerfil",
        child: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePerfilCerca),
              fit: BoxFit.contain
            )
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Datos(),
          SizedBox(height: separador),
          PlanDentalFicha()
        ],
      )
    ],
  );
}

Widget _citas(){
  return Container();
}