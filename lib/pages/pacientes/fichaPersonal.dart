import 'package:flutter/material.dart';
import 'package:poo_web/pages/datos.dart';

import '../../mystyle.dart';

double sangria = 10;
double separador = 30;

class FichaPersonal extends StatelessWidget {
  const FichaPersonal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var sW = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 350,
                width: sW/6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/perfil-hombre.png"),
                    fit: BoxFit.contain
                  )
                ),
              ),
              SizedBox(width: separador),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Datos(),
                    SizedBox(height: separador),
                    PlanDental(),
                    SizedBox(height: separador),
                    Recomendaciones()
                  ]
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Datos extends StatelessWidget {
  const Datos({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyRText(text: "Datos", tipo: "subtitleL", bold: 7, color: MyColors().colorOscuro()),
        Padding(
          padding: EdgeInsets.only(left: sangria),
          child: MyRText(text: "${datosPersonales["nombres"]} ${datosPersonales["apellidos"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
        ),
        Padding(
          padding: EdgeInsets.only(left: sangria),
          child: MyRText(text: "${datosPersonales["correo"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
        ),
        Padding(
          padding: EdgeInsets.only(left: sangria),
          child: Row(
            children: [
              MyRText(text: "DNI: ", tipo: "bodyL", bold: 6, color: MyColors().colorOscuro()),
              MyRText(text: "${datosPersonales["dni"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: sangria),
          child: Row(
            children: [
              MyRText(text: "Celular: ", tipo: "bodyL", bold: 6, color: MyColors().colorOscuro()),
              MyRText(text: "${datosPersonales["celular"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
            ],
          ),
        ),
      ],
    );
  }
}

class PlanDental extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyRText(text: "Plan Dental", tipo: "subtitleL", bold: 7, color: MyColors().colorOscuro()),
        Padding(
          padding: EdgeInsets.only(left: sangria),
          child: Row(
            children: [
              MyRText(text: "${datosPlan["plan"]} ", tipo: "bodyL", bold: 6, color: MyColors().colorOscuro()),
              MyRText(text: "${datosPlan["precio"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
            ],
          ),
        ),
      ],
    );
  }
}

class Recomendaciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyRText(text: "Recomendaciones", tipo: "subtitleL", bold: 7, color: MyColors().colorOscuro()),
        Padding(
          padding: EdgeInsets.only(left: sangria),
          child: MyRText(text: "Cuidar más el consumo de azúcar, pues hay aparición de caries.", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
        ),
      ], 
    );
  }
}