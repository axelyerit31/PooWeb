import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:poo_web/pages/pacientes/homePacientes.dart';
import '../../myWidgets.dart';
import '../../mystyle.dart';
import '../datos.dart';
import 'registro.dart';

List<String> formHints = [
  "Correo electrónico",
  "Ingrese su contraseña",
];

TextEditingController controlCorreo = new TextEditingController();
TextEditingController controlContrasena = new TextEditingController();

var urlLogin = "http://192.168.18.3/PooWeb/login.php";

//Alerta para mostrar cuando algo va mal
AlertDialog rowAlert(String mensaje, BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyRText(text: "Ha ocurrido un error", tipo: "body", color: MyColors().colorOscuro(), bold: 6),
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
              Navigator.pop(context);
            },
            child: MyRText(text: "Aceptar", tipo: "bodyLLL", color: Colors.white, bold: 5)
          )
        ],
      );
    }
  );
}

Future<List> login(BuildContext context) async{

  final response = await http.post(urlLogin, body: {
    "correo": controlCorreo.text,
    "contrasena": controlContrasena.text,
  });

  var resultado =  jsonDecode(response.body);

  if(resultado == "no existe"){
    rowAlert("El correo electrónico ingresado no se encuentra registrado.", context);
  }else if(resultado == "contrasena incorrecta"){
    rowAlert("La contraseña ingresada es incorecta.", context);
  }else{
    rolGlobal = resultado;
    print("Inicio de sesión exitoso, bienvenido $rolGlobal");
  }
}


List<TextEditingController> formControllers = [
  controlCorreo,
  controlContrasena,
];

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

bool bienCorreoForm = true;
bool bienContrasenaForm = true;

class _LoginState extends State<Login> {
 @override
  Widget build(BuildContext context) {

    var screenS = MediaQuery.of(context).size;
    var sW = screenS.width;
    var sH = screenS.height;
    double formW = sW > maxScreenSize ? sW : minScreenSize;
  
    double width = sW > maxScreenSize ? sW : maxScreenSize + 1/sW;
    double separador = lerpDouble(10, 16, sW/width);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: new Size.fromHeight(sizeAppBar),
        child: MyRAppBar(tipo: "login")
      ),
      body: SingleChildScrollView(
        child: Container(
          height: sW > maxScreenSize ? sizeMiPantalla-sizeAppBar : sizeMiPantalla-sizeAppBar-95,
          padding: EdgeInsets.only(top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: sW > maxScreenSize ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HideIf(
                    minWidth: maxScreenSize,
                    child: Hero(
                      tag: "tagImagenDentista",
                      child: Transform.scale(
                        scale: 1.10,
                        child: Container(
                          height: sW * 1 / 3,
                          width: sW * 2 / 4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/dentista-dibujo.png"),
                              alignment: Alignment.center
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                  HideIf(
                    minWidth: maxScreenSize,
                    child: Container(
                      margin: EdgeInsets.only(left: sW/50),
                      width: 1,
                      height: sH * 4/8,
                      color: MyColors().colorGris()
                    ),
                  ),
                  Container(
                    width: sW > maxScreenSize ? formW * 1 / 4 : formW * 7/10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        MyRText(
                          text: "Reserva tu cita completamente gratis",
                          color: MyColors().colorOscuro(),
                          tipo: "body",
                          bold: 4
                        ),

                        MyRText(
                          text: "Inicia Sesión",
                          color: MyColors().colorOscuro(),
                          tipo: "title",
                          bold: 7
                        ),
                        Container(height: separador * 0.7),

                        _formFields(sW),

                        Container(height: separador),
                        
                        Container(
                          constraints: BoxConstraints(minWidth: sW > maxScreenSize ? formW * 1 / 4 : formW * 7/10),
                          child: MyRButton(
                            onPressed: () {
                              if (controlCorreo.text == ""){
                                setState(() {
                                  bienCorreoForm = false;
                                  print(bienCorreoForm);
                                });
                              }else if (controlContrasena.text == ""){
                                setState(() {
                                  bienContrasenaForm = false;
                                  print(bienContrasenaForm);
                                });
                              }else{
                                login(context);
                              }
                            },
                            child: MyRText(
                              text: "Iniciar Sesión",
                              tipo: "buttonContent",
                              bold: 5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(height: separador),

                        Container(
                          constraints: BoxConstraints(minWidth: sW > maxScreenSize ? formW * 1 / 4 : formW * 7/10),
                          child: MyROutlineButton(
                            onPressed: () {},
                            child: MyRText(
                              text: "Iniciar Sesión con Google",
                              tipo: "buttonContent",
                              bold: 5,
                              color: MyColors().colorOscuro(),
                            ),
                            color: MyColors().colorOscuro(),
                          ),
                        ),
                        Container(height: separador* 0.7),

                        Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 8
                              )
                            ),
                            child: MyRText(
                              text: "Olvidé mi contraseña",
                              tipo: "bodyL",
                              bold: 5,
                              color: MyColors().colorGris()
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(height: separador* 2),

                        Row(
                          children: [
                            MyRText(
                              text: "¿No tienes cuenta?",
                              tipo: "bodyL",
                              bold: 5,
                              color: MyColors().colorGris()
                            ),
                            SizedBox(width: 5),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8
                                )
                              ),
                              child: MyRText(
                                text: "Registrate",
                                tipo: "bodyL",
                                bold: 6,
                                color: MyColors().colorOscuro()
                              ),
                              onPressed: (){
                                
                                Navigator.pushReplacement(context,
                                  new CupertinoPageRoute(builder: (context) => Registro()));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _formFields(double sW) {

    Color colorNormalForm = MyColors().colorGris();
    Color colorErrorForm = Colors.red;
    Color colorCorreoForm = bienCorreoForm ? colorNormalForm : colorErrorForm;
    Color colorContrasenaForm = bienContrasenaForm ? colorNormalForm : colorErrorForm;
  
    double width = sW > maxScreenSize ? sW : maxScreenSize + 1/sW;

    double separador = lerpDouble(10, 16, sW/width);

    return Container(
      child: Column(
        children: [
          Container(height: separador),

          MyRTextFormField(
            textColor: colorCorreoForm,
            onTap: (){
              setState(() {
                setState(() {
                  bienCorreoForm = true;
                });
              });
            },
            hintText: formHints[0],
            controller: formControllers[0],
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            formColor: MyColors().colorGrisClaro()
          ),
          Container(height: separador),

          MyRTextFormField(
            textColor: colorContrasenaForm,
            onTap: () {
              setState(() {
                bienContrasenaForm = true;
              });
            },
            hintText: formHints[1],
            controller: formControllers[1],
            keyboardType: TextInputType.text,
            obscureText: true,
            formColor: MyColors().colorGrisClaro()
          ),
          Container(height: separador),
        ]
      )
    );
  }
}