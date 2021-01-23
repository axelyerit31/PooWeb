import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../myWidgets.dart';
import '../../mystyle.dart';
import 'registro.dart';
List<String> formHints = [
  "Correo electrónico",
  "Ingrese su contraseña",
];

TextEditingController controlCorreo = new TextEditingController();
TextEditingController controlContrasena = new TextEditingController();

List<TextEditingController> formControllers = [
  controlCorreo,
  controlContrasena,
];

class Login extends StatelessWidget {
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
          height: sW > maxScreenSize ? sizeMiPantalla : sizeMiPantalla-95,
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
                            onPressed: () {},
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
              Footer()
            ],
          ),
        ),
      ),
    );
  }

  Container _formFields(double sW) {
  
  double width = sW > maxScreenSize ? sW : maxScreenSize + 1/sW;

  double separador = lerpDouble(10, 16, sW/width);

   return Container(
    child: Column(
      children: [
        Container(height: separador),

        MyRTextFormField(
          hintText: formHints[0],
          controller: formControllers[0],
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
        ),
        Container(height: separador),

        MyRTextFormField(
          hintText: formHints[1],
          controller: formControllers[1],
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
        Container(height: separador),
      ]
    )
  );
 }
}