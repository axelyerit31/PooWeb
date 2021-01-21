import 'dart:html';

import 'package:flutter/material.dart';
import 'package:poo_web/pages/datos.dart';

import '../../mystyle.dart';
import 'fichaPersonal.dart';



class Notificaciones extends StatelessWidget {
  const Notificaciones({
    Key key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          _header(),
          Column(          
            children: [
              SizedBox(
                height: separador
                 ,
              ),
              SingleChildScrollView(
                child: Builder(
                  builder: (BuildContext context){
                    return Column(
                      children:[
                        for (var i = 0; i <notificaciones.length; i++)
                          new _Notificaciones(
                            notificacion: notificaciones[i]["notificacion"],
                            comentario: notificaciones[i]["comentario"],
                          )
                      ]
                    );
                  } 
                ),
              )
            ]
          ),
        ],
      ),
    );
  }
}
Widget _header (){
  return Container(
    alignment: Alignment.center,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 250,
          width: 190,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePerfilCerca),
              fit: BoxFit.contain
            )
          ),
        ),
        SizedBox(width: separador),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Datos(),
            SizedBox(height: separador),
            PlanDentalFicha()
          ],
        )
      ],
    ),
  );
}
var noti1 = {
  "notificacion":"¡Hey! No olvides tu cita",
  "comentario":"John Doe, tienes una cita hoy a las 10:50 a.m. ¡No la olvides!"
  
};
var noti2 = {
  "notificacion":"Tu dentista te ofrece estas recomendaciones",
  "comentario":"John Doe, cuidar más el consumo de azúcar, pues hay aparición de caries."
};
var noti3 = {
  "notificacion":"Tu cita fue creada",
  "comentario":"John Doe, tu cita para el día 27 de Agosto a las 4:30 p.m. fue creada con éxito."
};
var noti4 = {
  "notificacion":"¡Tus dientes te lo agradecerán!",
  "comentario":"John Doe, agradadecemos que te hayas unido."
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
        bottom: 15,
        left: separador
      ),
      padding: EdgeInsets.symmetric(horizontal:sangria-5, vertical: sangria-5),
      child: Row(
        children: [
          Palito(), 
          Campanita(),
          TextNotificacion(notificacion, comentario),
          SizedBox(height: separador)  
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

