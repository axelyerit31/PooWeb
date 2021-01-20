import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../myWidgets.dart';
import '../../mystyle.dart';

List<String> formHints = [
  "Correo electrónico",
  "Ingrese una contraseña",
  "Nombres",
  "Apellidos",
  "Dni",
  "Número celular"
];

//Variables a enviar a php
TextEditingController controlCorreo = new TextEditingController();
TextEditingController controlContrasena = new TextEditingController();
TextEditingController controlNombres = new TextEditingController();
TextEditingController controlApellidos = new TextEditingController();
TextEditingController controlDni = new TextEditingController();
TextEditingController controlCelular = new TextEditingController();



List<TextEditingController> formControllers = [
  controlCorreo,
  controlContrasena,
  controlNombres,
  controlApellidos,
  controlDni,
  controlCelular
];

class Registro extends StatelessWidget {
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
        child: MyRAppBar(tipo: "registro")
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 34),
          child: Row(
            mainAxisAlignment: sW > maxScreenSize ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HideIf(
                minWidth: maxScreenSize,
                child: Hero(
                  tag: "tagImagenDentista",
                  child: Transform.scale(
                    scale: 1.15,
                    child: Container(
                      height: sW * 1 / 3,
                      width: sW * 2 / 4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/dentista-dibujo-full.png"),
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
                  height: sH * 5/8,
                  color: MyColors().colorGris()
                ),
              ),
              Container(
                width: sW > maxScreenSize ? formW * 1 / 4 : formW * 7/10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    MyRText(
                      text: "Registrarse es completamente gratis",
                      color: MyColors().colorOscuro(),
                      tipo: "body",
                      bold: 4
                    ),

                    MyRText(
                      text: "Regístrate",
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
                          text: "Registrarse",
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
                          text: "Registrarse con Google",
                          tipo: "buttonContent",
                          bold: 5,
                          color: MyColors().colorOscuro(),
                        ),
                        color: MyColors().colorOscuro(),
                      ),
                    ),

                  ],
                ),
              ),
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
        
        MyRTextFormField(
          hintText: formHints[2],
          controller: formControllers[2],
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
        ),
        Container(height: separador),
        
        MyRTextFormField(
          hintText: formHints[3],
          controller: formControllers[3],
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
        ),
        Container(height: separador),

        LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Container(
                  width: (constraints.maxWidth/2 - separador/2),
                  child: MyRTextFormField(
                    hintText: formHints[4],
                    controller: formControllers[4],
                    keyboardType: TextInputType.number,
                    obscureText: false,
                  ),
                ),
                Container(
                  width: (constraints.maxWidth/2 - separador/2),
                  child: MyRTextFormField(
                    hintText: formHints[5],
                    controller: formControllers[5],
                    keyboardType: TextInputType.phone,
                    obscureText: false,
                  ),
                ),
              ] 
            );
          }
        ),
        Container(height: separador),
      ]
    )
  );
 }
}