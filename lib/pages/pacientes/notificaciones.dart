import 'dart:html';

import 'package:flutter/material.dart';
import 'package:poo_web/pages/datos.dart';
import 'package:poo_web/pages/maquetaPerfil.dart';

import '../../mystyle.dart';
import 'fichaPersonal.dart';



class Notificaciones extends StatelessWidget {
  const Notificaciones({
    Key key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    double sW = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 520,
            width: sW/4,
            child: perfil()
          ),
          Column(    
            crossAxisAlignment: CrossAxisAlignment.start,      
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Datos(),
                  SizedBox(height: separador),
                  PlanDentalFicha()
                ],
              ),
              SizedBox(
                height: separador
              ),
              Container(
                width: sW/3,
                height: 247,
                child: SingleChildScrollView(
                  child: Builder(
                    builder: (BuildContext context){
                      return Column(
                        children:[
                          for (var i = 0; i <notificaciones.length; i++)
                            new _Notificaciones(
                              notificacion: notificaciones[i]["notificacion"],
                              comentario: notificaciones[i]["comentario"],
                            ),
                          for (var i = 0; i <notificaciones.length; i++)
                            new _Notificaciones(
                              notificacion: notificaciones[i]["notificacion"],
                              comentario: notificaciones[i]["comentario"],
                            ),
                        ]
                      );
                    } 
                  ),
                ),
              )
            ]
          ),
        ],
      ),
    );
  }
}

var noti1 = {
  "notificacion":"¡Hey! No olvides tu cita",
  "comentario":"${datosPersonales["nombres"]}, tienes una cita hoy a las 10:50 a.m. ¡No la olvides!"
};

var noti2 = {
  "notificacion":"Tu dentista te ofrece estas recomendaciones",
  "comentario":"${datosPersonales["nombres"]}, cuidar más el consumo de azúcar, pues hay aparición de caries."
};

var noti3 = {
  "notificacion":"Tu cita fue creada",
  "comentario":"${datosPersonales["nombres"]}, tu cita para el día 27 de Agosto a las 4:30 p.m. fue creada con éxito."
};

var noti4 = {
  "notificacion":"¡Tus dientes te lo agradecerán!",
  "comentario":"${datosPersonales["nombres"]}, agradadecemos que te hayas unido."
};

List notificaciones= [
  noti1,
  noti2,
  noti3,
  noti4
];

class _Notificaciones extends StatelessWidget {

  String notificacion;
  String comentario;

  _Notificaciones({Key key,this.notificacion,this.comentario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedL),
        color: Colors.white
      ),
      margin: EdgeInsets.only(
        top:0,
        right: separador,
        bottom: 17,
        left: separador
      ),
      padding: EdgeInsets.symmetric(horizontal:sangria-5, vertical: sangria-5),
      child: Row(
        children: [
          Palito(), 
          Campanita(),
          TextNotificacion(notificacion, comentario),
        ],
      )
    );
  }
}
Widget Palito(){
  return Container(
    decoration: BoxDecoration(
      color: MyColors().colorVerde(),
      borderRadius: BorderRadius.circular(roundedL)
    ),
    margin: EdgeInsets.only(right:sangria),
    width: 3,
    height: separador,
    
  );
  
}
Widget Campanita(){
  return Container(
    child: Icon(
      Icons.notifications,
      color: MyColors().colorAzulMedio(),
    ),
    margin: EdgeInsets.only(right:sangria), 
  ); 
}
Widget TextNotificacion (String notificacion, String comentario){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:[
      MyRText(
        text: notificacion,
        color: MyColors().colorOscuro(),
        bold: 6,
        tipo: "bodyL",
      ),
      MyRText(
      text: comentario,
      color: MyColors().colorAzulClaro(),
      bold: 6,
      tipo: "bodyLLL",
      )
        
    ]
  );
}

