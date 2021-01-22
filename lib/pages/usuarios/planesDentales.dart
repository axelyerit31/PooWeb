import 'package:flutter/material.dart';
import 'package:poo_web/mystyle.dart';

import '../../myWidgets.dart';

class PlanesDentalesHome extends StatefulWidget {
  @override
  _PlanesDentalesHomeState createState() => _PlanesDentalesHomeState();
}

class _PlanesDentalesHomeState extends State<PlanesDentalesHome> {
  @override
  Widget build(BuildContext context) {

    var sW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: new Size.fromHeight(sizeAppBar),
        child: MyRAppBar(
          tipo: "home",
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _Razones(sW),
              _MejorSonrisa(sW),
              _Planes(sW)
            ],
          )
        ),
      ),
    );
  }
}

class _Razones extends StatelessWidget {

  double sW;

  _Razones(this.sW);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeMiPantalla - sizeAppBar,
      width: 900,
      child: Column(
        children: [
          _elemento(
            image: "assets/iconos/dinero.png",
            encabezado: "Paga menos",
            descripcion: "Con nuestros planes asegurese de pagar menos por cubrir sus cuidados dentales."
          ),
          Transform.translate(
            offset: Offset(0, -100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _elemento(
                  image: "assets/iconos/seguro.png",
                  encabezado: "Protégete",
                  descripcion: "Descanse tranquilo sabiendo que frente a cualquier problema dental estamos nosotros para ayudarlo."
                ),
                _elemento(
                  image: "assets/iconos/sonrisa.png",
                  encabezado: "Sonrié más",
                  descripcion: "Sienta la plena confianza de poder mostrar una sonrisa envidiable, y a un bajo coste."
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _elemento({String image, String encabezado, String descripcion}){
    return Container(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain
              )
            ),
          ),
          MyRText(
            text: encabezado,
            tipo: "subtitle",
            color: MyColors().colorOscuro(),
            bold: 7
          ),
          MyRText(
            text: descripcion,
            tipo: "bodyB",
            color: MyColors().colorVerde(),
            bold: 5
          ),
        ],
      ),
    );
  }
}

Widget _MejorSonrisa(double sW){
  return Container(
    
  );
}

Widget _Planes(double sW){
  return Container(
    
  );
}