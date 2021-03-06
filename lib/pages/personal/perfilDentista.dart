import 'package:flutter/material.dart';
import 'package:poo_web/pages/datos.dart';

import '../../mystyle.dart';
import '../maquetaPerfil.dart';


class PerfilDentista extends StatelessWidget {
  const PerfilDentista({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var sW = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 350,
                width: sW/6,
                child: perfil()
              ),
              SizedBox(width: separador),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Datos(),
                  SizedBox(height: separador),
                
                ]
              )
            ],
          ),
          _Citas()
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

    if(rolGlobal == "paciente"){
      obtenerPaciente(datosPersonales["dni"]);
    }else if(rolGlobal == "personal"){
      obtenerPersonal(datosPersonales["nro"]);
    }else if(rolGlobal == "admin"){
      obtenerAdmin(datosPersonales["id"]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyRText(text: "Datos", tipo: "subtitleL", bold: 7, color: MyColors().colorOscuro()),
        if(rolGlobal == "personal")
          Padding(
            padding: EdgeInsets.only(left: sangria),
            child: Row(
              children: [
                MyRText(text: "Colegiado: ", tipo: "bodyL", bold: 6, color: MyColors().colorOscuro()),
                MyRText(text: "${datosPersonales["nro"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
              ],
            ),
          ),
        Padding(
          padding: EdgeInsets.only(left: sangria),
          child: MyRText(text: "${datosPersonales["nombres"]} ${datosPersonales["apellidos"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
        ),
        Padding(
          padding: EdgeInsets.only(left: sangria),
          child: MyRText(text: "${datosPersonales["correo"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
        ),
        if (rolGlobal == "paciente" || rolGlobal == "personal")
          Padding(
            padding: EdgeInsets.only(left: sangria),
            child: Row(
              children: [
                MyRText(text: "DNI: ", tipo: "bodyL", bold: 6, color: MyColors().colorOscuro()),
                MyRText(text: "${datosPersonales["dni"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
              ],
            ),
          ),
        if(rolGlobal == "paciente")
          Padding(
            padding: EdgeInsets.only(left: sangria),
            child: Row(
              children: [
                MyRText(text: "Celular: ", tipo: "bodyL", bold: 6, color: MyColors().colorOscuro()),
                MyRText(text: "${datosPersonales["celular"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
              ],
            ),
          ),
        if(rolGlobal == "paciente")
          Padding(
            padding: EdgeInsets.only(left: sangria),
            child: Row(
              children: [
                MyRText(text: "Dirección: ", tipo: "bodyL", bold: 6, color: MyColors().colorOscuro()),
                MyRText(text: "${datosPersonales["direccion"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
              ],
            ),
          ),
      ],
    );
  }
}

class _Citas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ultimaCita(),
          _proximaCita()
        ],
      )
    );
  }

  Widget _ultimaCita(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MyRText(text: "Última Cita", tipo: "subtitleL", bold: 7, color: MyColors().colorOscuro()),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(roundedB)
          ),
          height: 60,
          width: 400
        )
      ],
    );
  }

  Widget _proximaCita(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MyRText(text: "Próxima Cita", tipo: "subtitleL", bold: 7, color: MyColors().colorOscuro()),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(roundedB)
          ),
          height: 60,
          width: 400
        )
      ],
    );
  }
} 