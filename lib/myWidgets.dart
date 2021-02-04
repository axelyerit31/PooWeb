import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:poo_web/pages/datos.dart';
import 'package:poo_web/pages/maquetaPerfil.dart';
import 'package:poo_web/pages/usuarios/nosotros.dart';
import 'package:poo_web/pages/usuarios/planesDentales.dart';

import 'mystyle.dart';
import 'pages/pacientes/homePacientes.dart';
import 'pages/pacientes/pacientesPerfil.dart';
import 'pages/personal/personalPerfil.dart';
import 'pages/usuarios/cita.dart';
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

    print("Width actual: " + sW.toString());
    print("Height actual: " + screenS.height.toString());

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
                                    "Sonriamos",
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
                            tipo: "bodyL",
                            color: _cursorNosotros ? MyColors().colorClaro() : MyColors().colorOscuro(),
                            bold: 6
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
                            tipo: "bodyL",
                            color: _cursorPlanes ? MyColors().colorClaro() : MyColors().colorOscuro(),
                            bold: 6
                          ),
                        ),
                        SizedBox(width: sW/30),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white
                          ),
                          onPressed: (){
                            Navigator.push(context,
                              new CupertinoPageRoute(builder: (context) => CrearCita(),));
                          },
                          child: MyRText(
                            text: "Crear Cita",
                            tipo: "bodyL",
                            color: _cursorContacto ? MyColors().colorClaro() : MyColors().colorOscuro(),
                            bold: 6
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
          MyRText(
            text: datosPersonales["nombres"],
            tipo: "bodyL",
            color: Colors.white,
            bold: 6
          )
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
            CupertinoPageRoute(builder: (context) => Home()),(Route<dynamic> route) => false
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
          FadeInUp(
            duration: Duration(milliseconds: 2400),
            child: Container(
              margin: EdgeInsets.only(right: 100),
              width: sW * 2/6,
              child: _contentText(sW, context),
            ),
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
            child: _contentText(sW, context),
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

  Widget _contentImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/dentista-dibujo.png"),
          fit: BoxFit.contain
        )
      )
    );
  }

  Column _contentText(double sW, BuildContext context) {

    double separador = 15;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
          onPressed: () {
            Navigator.push(context,
              new CupertinoPageRoute(builder: (context) => CrearCita(),));
          },
        ),/* 
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
        ) */
      ]
    );
  }
}

class Content extends StatefulWidget {

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
    
  double _alturaOpcion = 45;
  double _anchoOpcion = 200;
  double _divisionPadding = 8;
  double _anchoPuntero = 2;
  int _indiceSeleccionado = 0;
  int _indiceApuntado = -1;

  void opcionApuntada(int valor){
    setState(() {
      _indiceApuntado = valor;
    });
  }

  void opcionSeleccionada(int valor){
    setState(() {
      _indiceSeleccionado = valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    

    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;

    return Column(
      children: [
        SizedBox(height: 120),
        _medium(sW),
        SizedBox(height: 120),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              height: sizeMiPantalla - sizeAppBar - 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/fondo-especialidades.png"),
                  fit: BoxFit.fitHeight,
                  alignment:Alignment.centerRight 
                )
              ),
            ),
            FutureBuilder<List>(
              future: obtenerEspecialiadesFuture(),
              builder: (context, snapshot) {
                if (snapshot.hasError){print(snapshot.error);}
                return snapshot.hasData
                  ? Container(
                      width: sW / 1.3,
                      padding: EdgeInsets.symmetric(vertical: 100),
                      height: sizeMiPantalla - sizeAppBar,
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyRText(
                                text: "Agendar una cita es completamente gratis",
                                tipo: "bodyB2",
                                color: MyColors().colorVerdeOscuro(),
                                bold: 5
                              ),
                              MyRText(
                                text: "Especialidades",
                                tipo: "title",
                                color: MyColors().colorOscuro(),
                                bold: 7
                              ),
                              SizedBox(height: separador/3),
                              Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  AnimatedContainer(
                                    curve: Curves.easeInOutCirc,
                                    duration: Duration(milliseconds: 300),
                                    margin: EdgeInsets.only(top: _indiceSeleccionado * _alturaOpcion),
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(
                                      left: _anchoOpcion/_divisionPadding/1.3 - (_anchoPuntero/2),
                                      top: _alturaOpcion / 4.5
                                     ),
                                    child: Container(
                                      height: _alturaOpcion / 2,
                                      width: _anchoPuntero,
                                      decoration: BoxDecoration(
                                        color: MyColors().colorOscuro(),
                                        borderRadius: BorderRadius.circular(roundedB)
                                      ),
                                    )
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      for (var i = 0; i < snapshot.data.length; i++)
                                        _opcion(snapshot.data[i]["nombre_esp"], i)
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(width: separador*4),
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: _especialidad(sW, snapshot.data[_indiceSeleccionado]["descripcion_esp"])
                          )
                        ]        
                      ),
                    )
                  : Center(child: CircularProgressIndicator());
              }
            ),
          ],
        ),
      ],
    );
  }

  Widget _medium(double sW){
    return Container(
      width: 1300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/sonriamosJuntos.png"),
          fit: BoxFit.fitWidth
        )
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyRText(
            text: "Protege tu felicidad con nuestros planes pensados para ti",
            tipo: "bodyL",
            bold: 5,
            color: MyColors().colorVerdeOscuro(),
          ),
          SizedBox(height: 15,),
          MyRText(
            text: "Planes desde S/ 39.90",
            tipo: "titleL",
            bold: 7,
            color: MyColors().colorOscuro(),
          ),
          SizedBox(height: 15,),
          MyRButton(
            onPressed: (){
              Navigator.push(context,
                new CupertinoPageRoute(builder: (context) => PlanesDentalesHome(),));
            },
            child: MyRText(
              text: "Ver los Planes",
              tipo: "buttonContent",
              bold: 5,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _opciones(double sW){

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < datosEspecialidades.length; i++)
          _opcion(datosEspecialidades[i]["nombre"], i)
      ],
    );
  }

  Widget _especialidad(double sW, String descripcion){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: Container(
            key: Key("$_indiceSeleccionado"),
            height: 250,
            width: 550,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(roundedL),
              image: DecorationImage(
                image: AssetImage("assets/especialidades/especialidad$_indiceSeleccionado.png"),
                fit: BoxFit.fitWidth
              )
            )
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: 580,
          child: MyRText(
            textAlign: TextAlign.justify,
            text: descripcion,
            tipo: "body",
            color: MyColors().colorOscuro(),
            bold:  5
          )
        ),
      ],
    );
  }

  Widget _opcion(String especialidad, int indice){

    Color logicaColor(){
      if (_indiceSeleccionado == indice){
        return MyColors().colorAzulClaro();
      }else if(_indiceApuntado == indice && _indiceSeleccionado != indice){
        return MyColors().colorGrisOscuro();
      }else{
        return MyColors().colorGris();
      }
    }

    return Container(
      height: _alturaOpcion,
      width: _anchoOpcion,
      padding: EdgeInsets.only(left: _anchoOpcion/_divisionPadding),
      alignment: Alignment.centerLeft,
      child: MouseRegion(
        onEnter: (_) {
          opcionApuntada(indice);
        },
        onExit: (_) {
          opcionApuntada(-1);
        },
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8
            )
          ),
          onPressed: () {
            print("Se toco $especialidad");
            opcionSeleccionada(indice);
          },
          child: MyRText(
            text: especialidad,
            color: logicaColor(),
            tipo: "bodyL",
            bold: _indiceSeleccionado == indice ? 6 : 5
          )
        ),
      )
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

        //Armando el fondo
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

        //
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
                      alignment: Alignment.bottomLeft,
                      scale: 0.1
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
AlertDialog rowAlert(String mensaje, BuildContext context, [String encabezado, String boton, Function function, bool admin, String boton2, Function function2]){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 300,
              child: MyRText(
                text: encabezado == null ? "¡Ha ocurrido un error!" : encabezado,
                tipo: "body",
                color: MyColors().colorOscuro(),
                bold: 6
              )
            ),
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
        content: Container(
          width: 300,
          child: MyRText(
            text: mensaje,
            tipo: "bodyLL", color: MyColors().colorAzulMedio(),
            bold: 5
          ),
        ),
        actions: [
          if (function2 != null && admin)
            MyROutlineButton(
              color: MyColors().colorOscuro(),
              onPressed: () {
                function2();
              },
              child: MyRText(text: boton2, tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)
            ),
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
