import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poo_web/mystyle.dart';
import 'package:flutter_cursor/flutter_cursor.dart';

import '../../myWidgets.dart';

class Maqueta extends StatefulWidget {

  final Widget child;

  const Maqueta({Key key, this.child}) : super(key: key);

  @override
  _MaquetaState createState() => _MaquetaState();
}

class _MaquetaState extends State<Maqueta> {

  double separador = 30;

  @override
  Widget build(BuildContext context) {

    double sW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: new Size.fromHeight(sizeAppBar),
        child: MyRAppBar(tipo: "perfil")
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: separador, horizontal: separador),
        child: Row(
          children: [
            Expanded(flex: 7, child: DrawBar(sW),),
            SizedBox(width: separador),
            Expanded(flex: 24, child: Main(sW),),
            SizedBox(width: separador),
            Expanded(flex: 12, child: Placeholder(),),
          ],
        )
      ),
    );
  }

  Widget Main(double sW){
    return Container(
      decoration: BoxDecoration(
        color: MyColors().colorClaro(),
        borderRadius: BorderRadius.circular(roundedB),
        image: DecorationImage(
          image: AssetImage("assets/perfil-bottomLeft.png"),
          alignment: Alignment.bottomRight,
          fit: BoxFit.fitHeight
        )
      ),
      height: double.infinity,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors().colorVerde(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(roundedB),
                bottomLeft: Radius.circular(roundedB),
              )
            ),
            width: sW/20
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(separador+13),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 350,
                        width: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/perfil-hombre.png"),
                            fit: BoxFit.contain
                          )
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      )
                    ],
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }


  int indexSeleccionado = 0;
  int indexApuntado = 10;
  double alturaOpcion = 55;

  void opcionApuntada(int valor){
    setState(() {
      indexApuntado = valor;
    });
  }
  void opcionSeleccionada(int valor){
    setState(() {
      indexSeleccionado = valor;
    });
  }

  List<String> opciones = [
    "Ficha Personal",
    "Cita",
    "Historial",
    "Plan Dental",
    "Notificaciones",
    "Editar Perfil"
  ];

  Widget DrawBar(double sW){

    double separador = sW/50;

    return Container(
      child: Stack(
        children: [
          AnimatedContainer(
            curve: Curves.easeInOutCirc,
            duration: Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: MyColors().colorClaro(),
              borderRadius: BorderRadius.circular(roundedL)
            ),
            height: alturaOpcion,
            width: double.infinity,
            margin: EdgeInsets.only(top: alturaOpcion*indexSeleccionado)
          ),
          Column(
            children: [
              opcionDraw(separador, 0),
              opcionDraw(separador, 1),
              opcionDraw(separador, 2),
              opcionDraw(separador, 3),
              opcionDraw(separador, 4),
              opcionDraw(separador, 5),
            ],
          ),
        ],
      ),
    );
  }

  Widget opcionDraw(double separador, int valor) {

    Color logicaLetra(){
      if(indexApuntado == valor && indexSeleccionado != valor){
        return MyColors().colorGrisOscuro();
      }else if(indexSeleccionado == valor){
        return MyColors().colorOscuro();
      }else{
        return MyColors().colorGris();
      }
    }

    return GestureDetector(
      onTap: () {opcionSeleccionada(valor);},
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (_) {opcionApuntada(valor);},
        onExit: (_) {opcionApuntada(10);},
        child: Container(
          height: alturaOpcion,
          width: double.infinity,
          alignment: Alignment.center,
          child: AnimatedContainer(
            curve: Curves.easeInOutSine,
            alignment: Alignment.centerLeft,
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.only(left: indexApuntado == valor ? 5 : 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: separador),
                Icon(FontAwesomeIcons.personBooth, color: logicaLetra()),
                SizedBox(width: separador),
                MyRText(text: opciones[valor], color: logicaLetra(), tipo: "bodyL", bold: 5,),
              ],
            ),
          )
        ),
      ),
    );
  }
}
