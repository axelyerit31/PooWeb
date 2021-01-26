import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poo_web/pages/datos.dart';
import 'package:poo_web/pages/usuarios/nosotros.dart';
import 'package:poo_web/pages/usuarios/planesDentales.dart';

import 'mystyle.dart';
import 'pages/pacientes/homePacientes.dart';
import 'pages/pacientes/pacientesPerfil.dart';
import 'pages/personal/personalPerfil.dart';
import 'pages/usuarios/home.dart';
import 'pages/usuarios/login.dart';
import 'pages/usuarios/registro.dart';

double sizeAppBar = 60;
double hFooter = 120;
int indicePantallaHome = 0;

class MyRAppBar extends StatefulWidget {

  final String tipo;

  const MyRAppBar({Key key, this.tipo}) : super(key: key);

  @override
  _MyRAppBarState createState() => _MyRAppBarState();
}

class _MyRAppBarState extends State<MyRAppBar> {

  void cambioPantalla(int valor){
    indicePantallaHome = valor;
    print(indicePantallaHome);
  }

  @override
  Widget build(BuildContext context) {

    Widget acciones(){
      if(widget.tipo == "usuario"){
        return accionesNoLogin(context);
      }else if(widget.tipo == "login"){
        return accionesLogin(context);
      }else if(widget.tipo == "registro"){
        return accionesRegistro(context);
      }else if(widget.tipo == "paciente" || widget.tipo == "personal" || widget.tipo == "admin"){
        return accionesUsuarios(context);
      }else if(widget.tipo == "perfil"){
        return accionesPerfil(context);
      }else{
        return Container(child: Text("No hay acciones"));
      }
    }

    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;

    bool _cursorNosotros = false;
    bool _cursorPlanes = false;
    bool _cursorContacto = false;

    return PreferredSize(
      preferredSize: new Size.fromHeight(sizeAppBar),
        child: Builder(
          builder: (BuildContext context){
            return Hero(
              tag: "tagAppBar2",
              child: Container(
                padding: EdgeInsets.only(top: 2),
                color: MyColors().colorAppBar(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Dental Care 2/16
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                        left: sW/35,
                        right: sW/25,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 45,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/logo.png"),
                                  fit: BoxFit.contain
                                )
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxHeight: 27),
                                  child: Text(
                                    "Sonríamos",
                                    style: GoogleFonts.reemKufi(color: MyColors().colorAzulClaro(), fontSize: 24, fontWeight: FontWeight.w600)
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0, -8),
                                  child: Container(
                                    constraints: BoxConstraints(maxHeight: 30),
                                    child: Text(
                                      "Juntos",
                                      style: GoogleFonts.reemKufi(color: Color(0xFFE9FFF3), fontSize: 24, fontWeight: FontWeight.w700)
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        onPressed: () {
                          bool regreso = Navigator.canPop(context);
                          if(regreso){
                            Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(builder: (context) => Home()),(Route<dynamic> route) => false
                            );
                          }
                        }
                      ),
                    ),
                    //Nosotros Planes dentales
                    HideIf(
                      minWidth: mediumScreenSize + 120,
                      child: Row(children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white
                          ),
                          onPressed: (){
                            Navigator.push(context,
                              new CupertinoPageRoute(builder: (context) => Nosotros(),));
                          },
                          child: MyRText(
                            text: "Nosotros",
                            tipo: "body",
                            color: _cursorNosotros ? MyColors().colorClaro() : MyColors().colorOscuro(),
                            bold: 5
                          ),
                        ),
                        SizedBox(width: sW/30),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white
                          ),
                          onPressed: (){
                            Navigator.push(context,
                              new CupertinoPageRoute(builder: (context) => PlanesDentalesHome(),));
                          },
                          child: MyRText(
                            text: "Planes Dentales",
                            tipo: "body",
                            color: _cursorPlanes ? MyColors().colorClaro() : MyColors().colorOscuro(),
                            bold: 5
                          ),
                        ),
                        SizedBox(width: sW/30),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white
                          ),
                          onPressed: (){
                            Navigator.push(context,
                              new CupertinoPageRoute(builder: (context) => Container(child: Text("Contacto")),));
                          },
                          child: MyRText(
                            text: "Contacto",
                            tipo: "body",
                            color: _cursorContacto ? MyColors().colorClaro() : MyColors().colorOscuro(),
                            bold: 5
                          ),
                        ),
                      ],),
                    ),
                    Container(
                      width: sW > mediumScreenSize+120 ? (sW*5/16) : (sW*8/16),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: sW/40),
                      child: acciones()
                    )
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
    
  Widget accionesNoLogin(BuildContext context) {
    double sW = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white.withOpacity(1)
          ),
          onPressed: (){
            Navigator.push(context,
              new CupertinoPageRoute(builder: (context) => Registro()));
          },
          child: MyRText(
            text: "Registrarme",
            tipo: "bodyL",
            color: MyColors().colorOscuro(),
            bold: 6
          ),
        ),
        SizedBox(width: sW/50),
        MyRButton(
          child: MyRText(
            text: "Iniciar Sesión",
            tipo: "bodyL",
            color: Colors.white,
            bold: 6
          ),
          color: MyColors().colorOscuro(),
          onPressed: () {
            Navigator.push(context,
              new CupertinoPageRoute(builder: (context) => Login()));
          },
        ),
      ],
    );
  }

  Widget accionesLogin(BuildContext context) {
    return MyRButton(
      child: MyRText(
        text: "Registrarme",
        tipo: "bodyL",
        color: Colors.white,
        bold: 6
      ),
      color: MyColors().colorOscuro(),
      onPressed: () {
            Navigator.pushReplacement(context,
              new CupertinoPageRoute(builder: (context) => Registro()));},
    );
  }

  Widget accionesRegistro(BuildContext context) {
    return MyRButton(
      child: MyRText(
        text: "Iniciar Sesión",
        tipo: "bodyL",
        color: Colors.white,
        bold: 6
      ),
      color: MyColors().colorOscuro(),
      onPressed: () {
        Navigator.pushReplacement(context,
          new CupertinoPageRoute(builder: (context) => Login()));},
    );
  }

  Widget accionesUsuarios(BuildContext context){
    return MyRButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white, 
          ),
          SizedBox(width: 25),
          FutureBuilder<List>(
            future: obtenerPacienteFicha(datosPersonales["dni"]),
            builder: (context, snapshot) {
              if(snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
              ? MyRText(
                  text: datosPersonales["nombres"],
                  tipo: "bodyL",
                  color: Colors.white,
                  bold: 6
                )
              : Container(width: 30);
            }
          ),
        ],
      ),
      color: MyColors().colorOscuro(),
      onPressed: () {
        if(widget.tipo == "paciente"){
          Navigator.pushReplacement(context,
          new CupertinoPageRoute(builder: (context) => PacientesPerfil()));
        }else if(widget.tipo == "personal"){
          Navigator.pushReplacement(context,
          new CupertinoPageRoute(builder: (context) => PersonalPerfil()));
        }else if(widget.tipo == "admin"){
          Navigator.pushReplacement(context,
          new CupertinoPageRoute(builder: (context) => PersonalPerfil()));
        }
      }
    );
  }

  Widget accionesPerfil(BuildContext context){
    return MyRButton(
      child: MyRText(
        text: "Ir al Inicio",
        tipo: "bodyL",
        color: Colors.white,
        bold: 6
      ),
      color: MyColors().colorOscuro(),
      onPressed: () {
        //bool regreso = Navigator.canPop(context);
        if(true){
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) => HomePacientes()),(Route<dynamic> route) => false
          );
        }
      }
    );
  }

}

class MyRHome extends StatelessWidget {
  const MyRHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Header(),
            Content(),
            Footer()
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;
    var sH = screenS.height;
    return Container(
      decoration: BoxDecoration(
        color: MyColors().colorClaro(),
        image: DecorationImage(
          image: AssetImage("assets/fondo_home.png"),
          fit: BoxFit.fitWidth
        )
      ),
      padding: EdgeInsets.only(
        top: 0
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(
            builder: (BuildContext context){
              if( sW > maxScreenSize){
                return _contentEscritorioMax(context, sW);
              }else{
                return _contentEscritorioMin(context, sW);
              }
            },
          )
        ],
      ),
    );
  }
  
  Widget _contentEscritorioMax(BuildContext context, double sW){
    return Container(
      height: sizeMiPantalla - sizeAppBar,
      padding: EdgeInsets.only(
        bottom: sW/34
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Texto
          Container(
            margin: EdgeInsets.only(right: 100),
            width: sW * 2/6,
            child: _contentText(sW),
          ),
          
          //Imagen
          Hero(
            tag: "tagImagenDentista",
            child: Transform.translate(
              offset: Offset(120, 0),
              child: Transform.scale(
                scale: 1.7,
                alignment: Alignment.centerRight,
                child: Container(
                  width: sW * 1 / 3,
                  child: _contentImage()
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _contentEscritorioMin(BuildContext context, double sW){

    double separador = sW/9;

    return Container(
      //padding: EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: separador),
          Container(
            alignment: Alignment.centerLeft,
            width: sW * 3/3.5,
            padding: EdgeInsets.only(left: sW/20),
            child: _contentText(sW),
          ),
          SizedBox(height: separador),
          Container(
            height: sW / 1.7,
            width: sW/1.15,
            child: _contentImage(),
          ),
          SizedBox(height: separador),
        ],
      ),
    );
  }

  Container _contentImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/dentista-dibujo.png"),
          fit: BoxFit.contain
        )
      )
    );
  }

  Column _contentText(double sW) {

    double separador = 15;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyRText(
          text: "La vida es mejor cuando sonríes",
          color: MyColors().colorOscuro(),
          tipo: "title",
          bold: 7
        ),
        SizedBox(height: separador * 1/3),
        Container(height: 2.5, width: sW/20, color: MyColors().colorAzulClaro(),),
        SizedBox(height: separador),
        MyRText(
          text: "Haz tu sonrisa perfecta con nosotros",
          color: MyColors().colorVerdeOscuro(),
          tipo: "bodyB",
          bold: 5
        ),
        SizedBox(height: separador*1.8),
        MyRButton(
          child: MyRText(
            text: "Crear Cita",
            color: Colors.white,
            tipo: "buttonContent",
            bold: 5
          ),
          onPressed: () {},
        ),
        SizedBox(height: separador),
        MyROutlineButton(
          child: MyRText(
            text: "¿Por qué debo cuidar mis dientes?",
            color: MyColors().colorOscuro(),
            tipo: "buttonContent",
            bold: 5
          ),
          onPressed: () {},
          color: MyColors().colorOscuro(),
        )
      ]
    );
  }
}

class Content extends StatelessWidget {

  final List<String> especialidadesNombres = [
    "Ortodoncia",
    "Periodoncia",
    "Limpieza dental",
    "Implantes"
  ];

  final List<String> especialidadesImages = [
    "especialidad2.jpg",
    "especialidad3.jpg",
    "especialidad4.jpg",
    "especialidad5.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;
    return Container(
      height: 100,
      alignment: Alignment.center,
      child: Text("Container"),
    );
  }
}

class Footer extends StatelessWidget {
  final double separador = 15;

  @override
  Widget build(BuildContext context) {
    var sW = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: hFooter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF5E81FE),
                Color(0xff456BF1),
              ]
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: sW / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _topFooter(sW),
                    Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    Container(
                      child: _bottomFooter(sW),
                      alignment: Alignment.centerRight,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: hFooter,
          width: double.infinity,
          child: Row(
            children: [
              Transform.scale(
                alignment: Alignment.bottomLeft,
                scale: 1.5,
                child: Container(
                  width: sW/2,
                  height: hFooter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/footer/bottomLeft.png"),
                      alignment: Alignment.bottomLeft
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: sW > minScreenSize+100 ? Offset(0, 0) : Offset(13, 0),
                child: Container(
                  width: sW/2,
                  height: hFooter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/footer/bottomRight.png"),
                      alignment: Alignment.bottomRight
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ],
    );
  }

  final List<Icon> iconFooter = [
    Icon(FontAwesomeIcons.facebook),
    Icon(FontAwesomeIcons.twitter),
    Icon(FontAwesomeIcons.instagram),
    Icon(FontAwesomeIcons.whatsapp),
  ];

  Widget _topFooter(double sW) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: sW/200),
              child: MyRText(
                text: "Contáctanos",
                tipo: "bodyB",
                color: Colors.white,
                bold: 6
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < 4; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sW/250),
                    child: CircleAvatar(
                      child: IconButton(
                        alignment: Alignment.topRight,
                        icon: iconFooter[i],
                        onPressed: () {print("HOLA");}
                      ),
                      backgroundColor: Colors.white
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final List<String> bottomFooter = [
    "Servicios",
    "Nosotros",
    "Contacto",
    "Privacidad"
  ];

  Widget _bottomFooter(double sW) {
    return Container(
      width: 450,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < bottomFooter.length; i++)
            MyRText(
              text: bottomFooter[i],
              tipo: "bodyL",
              color: Colors.white,
              bold: 5
            )
        ]
      ),
    );
  }
}


//Alerta para mostrar cuando algo va mal
AlertDialog rowAlert(String mensaje, BuildContext context, [String encabezado, String boton, Function function]){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyRText(text: encabezado == null ? "¡Ha ocurrido un error!" : encabezado, tipo: "body", color: MyColors().colorOscuro(), bold: 6),
            Transform.translate(
              offset: Offset(20, -20),
              child: Container(
                child: IconButton(
                  splashRadius: 15,
                  icon: Icon(Icons.close, color: MyColors().colorAzulMedio()),
                  onPressed: () {
                    Navigator.pop(context);
                  }
                ),
              ),
            )
          ],
        ),
        content: MyRText(
          text: mensaje,
          tipo: "bodyLL", color: MyColors().colorAzulMedio(),
          bold: 5
        ),
        actions: [
          MyRButton(
            onPressed: () {
              function == null ? Navigator.pop(context) : function();
            },
            child: MyRText(text: boton == null ? "Aceptar" : boton, tipo: "bodyLLL", color: Colors.white, bold: 5)
          )
        ],
      );
    }
  );
}
