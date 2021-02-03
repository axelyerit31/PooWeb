import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poo_web/pages/usuarios/registro.dart';

import '../../mystyle.dart';
import 'home.dart';


class DespuesCita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double ancho = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children:<Widget> [
          Opacity(
            opacity: 0.35,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('fondo.jpg'))
              ),

            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 722,
                  height: 420,
                  margin: EdgeInsets.only(top: 30, bottom: 5),
                  child: 
                    Image.asset('assets/dentista-loading.png'),
                  constraints: BoxConstraints.tightForFinite(),
                ),
                Container(
                  child: MyRText(
                    text: "Gracias por reservar una cita con nosotros",
                    tipo: "subtitle",
                    color: MyColors().colorOscuro(),
                    bold: 7,
                  ),
                  margin: EdgeInsets.only(bottom: 4 ),
                ),
                Container(
                  width: ancho*2/5,
                  child: MyRText(
                    textAlign: TextAlign.center,
                    text: "Regístrate y podrás acceder a tus citas y ficha de paciente, todo desde esta plataforma.",
                    color: MyColors().colorVerdeOscuro(),
                    tipo: "bodyL",
                    bold: 5,
                  ),
                  margin: EdgeInsets.only(bottom: 30),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyROutlineButton(
                        color: Colors.blue,
                        onPressed: (){
                          Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(builder: (context) => Home()),(Route<dynamic> route) => false
                          );
                        }, 
                        child: MyRText(
                          text: "Volver al inicio",
                          color: Colors.blue,
                          tipo: "buttonContent",
                          bold: 5,
                        )
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      MyRButton(
                        onPressed: (){
                          Navigator.push(context,
                            new CupertinoPageRoute(builder: (context) => Registro()));
                        }, 
                        child: MyRText(
                          text: "Registrarme",
                          color: Colors.white,
                          tipo: "buttonContent",
                          bold: 5,
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
