import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poo_web/mystyle.dart';
import 'package:poo_web/pages/personal/citaDentista.dart';
import 'package:poo_web/pages/personal/perfilDentista.dart';
import 'package:http/http.dart' as http;
import '../myWidgets.dart';
import 'pacientes/citas.dart';
import 'pacientes/editarPerfil.dart';
import 'pacientes/fichaPersonal.dart';
import 'pacientes/planDental.dart';
import 'datos.dart';
import 'personal/clientes.dart';
import 'personal/especialidades.dart';
import 'usuarios/home.dart';
import 'usuarios/registro.dart';

final urlConfirmarContrasena = url + "confirmarContrasena.php";
TextEditingController _controlContrasena = TextEditingController();


Future<String> confirmarContrasena() async{
  final response = await http.post(urlConfirmarContrasena, body: {
    "dni": datosPersonales["dni"],
    "pass": _controlContrasena.text
  });

  var resultado = jsonDecode(response.body)[0];
  return resultado;
}



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
      if(nombres.substring(i, i+1) == " "){
        break;
      }else{
        nombre += nombres.substring(i, i+1);
      }
    }
  }

  //Obtengo el primer apellido
  for (var i = 0; i < apellidos.length; i++) {
    if(true){
      if(apellidos.substring(i, i+1) == " "){
        break;
      }else{
        apellido += apellidos.substring(i, i+1);
      }
    }
  }
 
  String nombreApellido = datosPersonales["nombres"] == "Carlos Eduardo"
    ? datosPersonales["nombres"]
    : nombre + " " + apellido;

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

List<Widget> pantallas;

class Maqueta extends StatefulWidget {

  final String rol;
  final List<String> opciones;
  final List<String> iconosOpciones;

  const Maqueta({Key key, this.rol, this.opciones, this.iconosOpciones}) : super(key: key);

  @override
  _MaquetaState createState() => _MaquetaState();
}

class _MaquetaState extends State<Maqueta> {

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
      //Llamando funciones que obtendran datos privados del cliente, se llaman aqui para que entonces ya esten cargadas
      obtenerCitas();
    }
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

              //DrawBar
              Container(
                height: altura,
                width: sWActual * 7/43,
                child: DrawBar(
                  sW: sW, 
                  state: opcionSeleccionada,
                  rol: widget.rol,
                  opciones: widget.opciones,
                  iconos: widget.iconosOpciones
                ),
              ),
              
              SizedBox(width: separador),
              
              //Main
              Container(height: altura, width: sWActual * 36/43, child: Main(sW)),
            ],
          )
        ),
      ),
    );
  }

  Widget Main(double sW){

    PageController _controllerPageView = PageController(
      initialPage: 0
    );

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
                  child: PageView(
                    controller: _controllerPageView,
                    scrollDirection: Axis.vertical,
                    children: [
                      Builder(
                        builder: (BuildContext context){
                          if(indexSeleccionado < widget.iconosOpciones.length-1){
                            ultimoIndexSeleccionado = indexSeleccionado;
                            ultimoWidget = pantallas[indexSeleccionado];
                            return pantallas[indexSeleccionado];
                          }else{
                            return pantallas[ultimoIndexSeleccionado];
                          }
                        },
                      ),
                    ],
                  )
                )
              )
            ],
          )
        ),
      ],
    );
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
}


class DrawBar extends StatefulWidget {

  final ValueChanged<int> state;
  final double sW;
  final List<String> opciones;
  final List<String> iconos;
  final String rol;

  const DrawBar({
    Key key, this.state,
    this.sW,
    this.opciones,
    this.iconos,
    this.rol
  }) : super(key: key);
  

  @override
  _DrawBarState createState() => _DrawBarState();
}

class _DrawBarState extends State<DrawBar> {
  List<String> opciones;
  List<String> iconos;

  //Obtener los datos de que pantallas, opciones e iconos habran, dados desde [rol]Perfil
  void obtenerDatos(){
    if(widget.rol == "paciente"){
      pantallas = [
        FichaPersonal(),
        Citas(state: widget.state),
        PlanDental(),
        //Notificaciones(),
        EditarPerfil(state: widget.state)
      ];
    }else if(widget.rol == "personal"){
      pantallas = [
        PerfilDentista (),
        CitasDentista (state: widget.state),
        Clientes(),
        EspecialidadesPersonal(state: widget.state),
      ];
    }else if(widget.rol == "admin"){
      pantallas = [
        Container(),
        Container(),
        Clientes(),
        EspecialidadesPersonal(state: widget.state),
      ];
    }
    opciones = widget.opciones;
    iconos = widget.iconos;
  }

  void opcionApuntada(int valor){
    setState(() {
      indexApuntado = valor;
      print("EL index $valor fue apuntado");
    });
  }

  double alturaOpcion = 55;

  @override
  Widget build(BuildContext context) {

    obtenerDatos();

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
              for (var i = 0; i < widget.opciones.length; i++)
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
        if(valor == widget.opciones.length-1){
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
                      widget.state(ultimoIndexSeleccionado);
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
                      planDentalDefecto = 0;
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
        }else if(rolGlobal == "paciente" && valor == widget.opciones.length-2){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: MyRText(
                  text: "Confirme su contraseña",
                  tipo: "body", color: MyColors().colorOscuro(),
                  bold: 6
                ),
                content: Container(
                  width: 300,
                  child: MyRTextFormField(
                    textColor: MyColors().colorGris(),
                    hintText: "Contraseña",
                    controller: _controlContrasena,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    formColor: MyColors().colorGrisClaro()
                  )
                ),
                actions: [
                  MyROutlineButton(
                    onPressed: (){
                      Navigator.pop(context);
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
                    onPressed: () async{
                      if(_controlContrasena.text == ""){
                        rowAlert("El campo contraseña está vacío.", context);
                      }else{
                        final response = await http.post(urlConfirmarContrasena, body: {
                          "dni": datosPersonales["dni"],
                          "pass": _controlContrasena.text
                        });

                        var resultado = jsonDecode(response.body)[0];

                        if(resultado == "correcta"){
                          print("BIEN");
                          Navigator.pop(context);
                          widget.state(valor);
                          _controlContrasena.clear();
                        }else{
                          print("MAL");
                          Navigator.pop(context);
                          widget.state(ultimoIndexSeleccionado);
                          _controlContrasena.clear();
                        }
                      }
                    },
                    child: MyRText(
                      text: "Confirmar",
                      tipo: "bodyLL",
                      color: Colors.white,
                      bold: 5
                    )
                  )
                ],
              );
            }
          );
        }else{
          widget.state(valor);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {opcionApuntada(valor);},
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
                    widget.iconos[valor],
                    color: logicaIcono(),
                    alignment: Alignment.center,
                  )
                ),
                SizedBox(width: separador * 3/5),
                MyRText(text: widget.opciones[valor], color: logicaLetra(), tipo: "bodyL", bold: 5,),
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