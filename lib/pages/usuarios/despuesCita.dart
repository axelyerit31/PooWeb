import 'package:flutter/material.dart';

import '../../mystyle.dart';


class MiPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void Function() {}
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
                    Image.asset('densista_loading.png'),
                  constraints: BoxConstraints.tightForFinite(),
                ),
                Container(
                  child: MyRText(
                          text: "Gracias por reservar una cita con nosotros",
                          color: Colors.blue,
                          tipo: "subtitle",
                          bold: 7,
                        ),
                  margin: EdgeInsets.only(bottom: 4 ),
                ),
                Container(
                  width: ancho*2/5,
                  child: MyRText(
                    textAlign: TextAlign.center,
                    text: "Registrate y podras acceder a tus citas, ficha de pacientee historial dental,todo desde esta plataforma.",
                    color: Colors.blue,
                    tipo: "bodyB",
                    bold: 3,
                  ),
                  margin: EdgeInsets.only(bottom: 30),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyROutlineButton(
                        color: Colors.blue,
                        onPressed: Function, 
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
                        onPressed: Function, 
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
