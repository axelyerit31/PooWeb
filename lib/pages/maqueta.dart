import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poo_web/mystyle.dart';

import '../myWidgets.dart';
import 'datos.dart';
import 'pacientes/citas.dart';
import 'pacientes/fichaPersonal.dart';
import 'pacientes/planDental.dart';

//funcion para obtner el primer nombre y primer apellido de forma vertical
String nombresVertical(){
  String resultado = "";
  String nombres = datosPersonales["nombres"];
  String apellidos = datosPersonales["apellidos"];
  String nombre = "";
  String apellido = "";

  //Obtengo solo el primer nombre
  for (var i = 0; i < nombres.length; i++) {
    if(true){
      nombre += nombres.substring(i, i+1);
      if(nombres.substring(i, i+1) == " "){
        break;
      }
    }
  }

  //Obtengo el primer apellido
  for (var i = 0; i < apellidos.length; i++) {
    if(true){
      apellido += apellidos.substring(i, i+1);
      if(apellidos.substring(i, i+1) == " "){
        break;
      }
    }
  }

  String nombreApellido = nombre + apellido;

  for (var i = 0; i < nombreApellido.length; i++) {
    resultado += nombreApellido.substring(i, i+1);
    resultado += "\n";
  }

  return resultado.trim();
}


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
    
    print(nombresVertical());

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
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 2,
              width: 2,
              child: perfil()
            ),
            Container(
              height: 2,
              width: 2,
              child: perfilCerca()
            ),
          ],
        ),
        Container(
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
              //Barra Verde
              Container(
                decoration: BoxDecoration(
                  color: MyColors().colorVerde(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(roundedB),
                    bottomLeft: Radius.circular(roundedB),
                  )
                ),
                height: double.infinity,
                width: sW/20,
                alignment: Alignment.center,
                child: MyRText(
                  text: nombresVertical(),
                  tipo: "subtitle",
                  color: MyColors().colorOscuro(),
                  bold: 7
                ),
              ),

              //Contenido Principal
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(separador+13),
                  child: pantallas[indexSeleccionado],
                )
              )
            ],
          )
        ),
      ],
    );
  }

  List<Widget> pantallas = [
    FichaPersonal(),
    Citas(),
    PlanDental(),
    Container(),
    Container(),
  ];


  int indexSeleccionado = 2;
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
              for (var i = 0; i < opciones.length; i++)
                opcionDraw(separador, i)
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

    double marginOpcion = 5;

    double logicaMargin(){
      if(indexApuntado == valor){
        return marginOpcion;
      }else if(indexSeleccionado == valor){
        return marginOpcion;
      }else{
        return 0;
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
            margin: EdgeInsets.only(left: logicaMargin()),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: separador * 3/5),
                Icon(FontAwesomeIcons.personBooth, color: logicaLetra()),
                SizedBox(width: separador * 3/5),
                MyRText(text: opciones[valor], color: logicaLetra(), tipo: "bodyL", bold: 5,),
              ],
            ),
          )
        ),
      ),
    );
  }
}

//Widget con la imagen del perfil cerca, que usare para todas las pantallas donde vaya imagen de perfil cerca
Widget perfilCerca(){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagePerfilCerca),
        fit: BoxFit.contain
      )
    ),
  );
}

//Widget con la imagen del perfil, que usare para todas las pantallas donde vaya imagen de perfil
Widget perfil(){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagePerfil),
        fit: BoxFit.contain
      )
    ),
  );
}