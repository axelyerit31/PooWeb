import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poo_web/mystyle.dart';

import '../myWidgets.dart';
import 'pacientes/citas.dart';
import 'pacientes/editarPerfil.dart';
import 'pacientes/fichaPersonal.dart';
import 'pacientes/notificaciones.dart';
import 'pacientes/planDental.dart';
import 'datos.dart';
import 'personal/clientes.dart';
import 'personal/especialidades.dart';
import 'usuarios/home.dart';

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

//Widget para almacenar el ultimo widget mostrado antes de presionar "Cerrar Sesion", el cual no devuelve ni un widget
Widget ultimoWidget;
String imagePerfil;
String imagePerfilCerca;

//index para el manejo de pantallas de los perfiles
int indexSeleccionado = 0;
int ultimoIndexSeleccionado;
int indexApuntado = 10;

class Maqueta extends StatefulWidget {

  final String rol;
  final List<String> opciones;
  final List<String> iconosOpciones;

  const Maqueta({Key key, this.rol, this.opciones, this.iconosOpciones}) : super(key: key);

  @override
  _MaquetaState createState() => _MaquetaState();
}

class _MaquetaState extends State<Maqueta> {

  

  List<Widget> pantallas;
  List<String> opciones;
  List<String> iconos;

  //Obtener los datos de que pantallas, opciones e iconos habran, dados desde [rol]Perfil
  void obtenerDatos(){
    if(widget.rol == "paciente"){
      pantallas = [
        FichaPersonal(),
        Citas(state: opcionSeleccionada),
        PlanDental(),
        //Notificaciones(),
        EditarPerfil(state: opcionSeleccionada)
      ];
    }else if(widget.rol == "personal"){
      pantallas = [
        Container(),
        Container(),
        Clientes(),
        EspecialidadesPersonal(),
        Container(),
      ];
    }else if(widget.rol == "admin"){
      pantallas = [
        Container(),
        Container(),
        Clientes(),
        Clientes(),
        EspecialidadesPersonal(),
        Container(),
      ];
    }
    opciones = widget.opciones;
    iconos = widget.iconosOpciones;
  }

  void obtenerImagenes(){
    if(widget.rol == "paciente"){
      if(datosPersonales["sexo"] == "Masculino"){
        imagePerfil = "assets/perfil-hombre.png";
        imagePerfilCerca = "assets/perfil-hombre-cerca.png";
      }else{
        imagePerfil = "assets/perfil-mujer.png";
        imagePerfilCerca = "assets/perfil-mujer-cerca.png";
      }
    }else if(widget.rol == "personal"){
      imagePerfil = "assets/perfil-dentista.png";
      imagePerfilCerca = "assets/perfil-dentista-cerca.png";
    }else if(widget.rol == "admin"){
      imagePerfil = "assets/perfil-hombre.png";
      imagePerfilCerca = "assets/perfil-hombre-cerca.png";
    }
  }

  double separador = 30;

  @override
  Widget build(BuildContext context) {

    if(widget.rol == "paciente"){
      //Llamando funciones que obtendran datos privados del cliente, se llaman aqui para que entonce ya esten cargadas
      obtenerCitas();
    }

    obtenerDatos();
    obtenerImagenes();

    double sW = MediaQuery.of(context).size.width;
    double sWActual = sW - separador*3;
    double altura = sizeMiPantalla - sizeAppBar - separador*2;

    print(altura);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: new Size.fromHeight(sizeAppBar),
        child: MyRAppBar(tipo: "perfil")
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: separador, horizontal: separador),
          child: Row(
            children: [
              Container(height: altura, width: sWActual * 7/43, child: DrawBar(sW)),
              //Expanded(flex: 7, child: DrawBar(sW),),
              SizedBox(width: separador),
              Container(height: altura, width: sWActual * 36/43, child: Main(sW)),
              //Expanded(flex: 24, child: Main(sW),),
              //SizedBox(width: separador),
              //Container(height: altura, width: sWActual * 12/43, child: Placeholder()),
              //Expanded(flex: 12, child: Placeholder(),),
            ],
          )
        ),
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
                  textAlign: TextAlign.center,
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
                  child: Builder(
                    builder: (BuildContext context){
                      if(indexSeleccionado < iconos.length-1){
                        ultimoIndexSeleccionado = indexSeleccionado;
                        ultimoWidget = pantallas[indexSeleccionado];
                        return pantallas[indexSeleccionado];
                      }else{
                        return ultimoWidget;
                      }
                    },
                  )
                )
              )
            ],
          )
        ),
      ],
    );
  }
  double alturaOpcion = 55;

  void opcionApuntada(int valor){
    setState(() {
      indexApuntado = valor;
    });
  }
  void opcionSeleccionada(int valor){
    if(widget.rol == "paciente"){
      obtenerPaciente(datosPersonales["dni"]);
    }else if (widget.rol == "personal"){
      obtenerPersonal(datosPersonales["nro"]);
    }else{
      obtenerAdmin(datosPersonales["id"]);
    }
    
    setState(() {
      indexSeleccionado = valor;
    });
  }

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

    Color logicaIcono(){
      if(indexApuntado == valor && indexSeleccionado != valor){
        return MyColors().colorGrisOscuro();
      }else if(indexSeleccionado == valor){
        return null;
      }else{
        return MyColors().colorGris();
      }
    }

    return GestureDetector(
      onTap: () {
        opcionSeleccionada(valor);
        if(valor == opciones.length-1){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: MyRText(
                  text: "¿Está seguro de que desea cerrar sesión?",
                  tipo: "body", color: MyColors().colorOscuro(),
                  bold: 6
                ),
                content: MyRText(
                  text: "Estamos aquí siempre para ayudarle, regrese cuando quiera.",
                  tipo: "bodyLL", color: MyColors().colorAzulMedio(),
                  bold: 5
                ),
                actions: [
                  MyROutlineButton(
                    onPressed: (){
                      Navigator.pop(context);
                      opcionSeleccionada(ultimoIndexSeleccionado);
                    },
                    child: MyRText(
                      text: "Cancelar",
                      tipo: "bodyLL",
                      color: MyColors().colorOscuro(),
                      bold: 5
                    ),
                    color: MyColors().colorOscuro(),
                  ),
                  MyRButton(
                    onPressed: () {
                      rolGlobal = "usuario";
                      datosPersonales.clear();
                      datosCitas.clear();
                      indexSeleccionado = 0;
                      Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(builder: (context) => Home()),(Route<dynamic> route) => false
                      );
                    },
                    child: MyRText(
                      text: "Cerrar Sesión",
                      tipo: "bodyLL",
                      color: Colors.white,
                      bold: 5
                    )
                  )
                ],
              );
            }
          );
        }
      },
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
                Container(
                  height: 14,
                  width: 16,
                  child: Image.asset(
                    iconos[valor],
                    color: logicaIcono(),
                    alignment: Alignment.center,
                  )
                ),
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