import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poo_web/pages/datos.dart';
import 'package:poo_web/pages/pacientes/pacientesPerfil.dart';
import 'package:poo_web/pages/usuarios/login.dart';

import 'package:http/http.dart' as http;

import '../../myWidgets.dart';
import '../../mystyle.dart';

List<String> formHintsRegistro = [
  "Correo electrónico",
  "Ingrese una contraseña",
  "Nombres",
  "Apellidos",
  "Dni",
  "Número celular",
  "Sexo",
  "Dirección"
];

//Variables a enviar a php
TextEditingController controlCorreo = new TextEditingController();
TextEditingController controlContrasena = new TextEditingController();
TextEditingController controlNombres = new TextEditingController();
TextEditingController controlApellidos = new TextEditingController();
TextEditingController controlDni = new TextEditingController();
TextEditingController controlCelular = new TextEditingController();
String controlSexo;
TextEditingController controlDireccion = new TextEditingController();

List formControllersRegistro = [
  controlCorreo,
  controlContrasena,
  controlNombres,
  controlApellidos,
  controlDni,
  controlCelular,
  controlSexo,
  controlDireccion
];

var urlRegistro = "http://192.168.18.3/PooWeb/registro.php";

void registroPaciente(){
  http.post(urlRegistro, body: {
    "correo": controlCorreo.text,
    "contrasena": controlContrasena.text,
    "nombres": controlNombres.text,
    "apellidos": controlApellidos.text,
    "dni": controlDni.text,
    "celular": controlCelular.text,
    "sexo": controlSexo,
    "direccion": controlDireccion.text,
  });
}

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {

  void dropDownButton(value){
    setState(() {
      controlSexo = value;
    });
  }


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
                        onPressed: () {
                          bool vacio = false;
                          for (var i = 0; i < formControllersRegistro.length; i++) {
                            if(i == 6){
                              if(controlSexo == ""){
                                vacio = true;
                                print("controlSexo esta vacio");
                              }
                            }else{
                              if(formControllersRegistro[i].text == ""){
                                vacio = true;
                                print("${formHintsRegistro[i]} esta vacío");
                              }
                            }
                          }
                          if(vacio){
                            rowAlert("Hay uno o más campos vacíos, asegúrese de llenar todos.", context);
                          }else{
                            registroPaciente();
                            datosPersonales = {
                              "dni" : controlDni.text,
                              "nombres" : controlNombres.text,
                              "apellidos" : controlApellidos.text,
                              "correo" : controlCorreo.text,
                              "celular" : controlCelular.text,
                              "sexo" : controlSexo,
                              "direccion" : controlDireccion.text,
                            };
                            rolGlobal = "paciente";
                            Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(builder: (context) => PacientesPerfil()),(Route<dynamic> route) => false
                            );
                          }
                        },
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
    
    double formW = sW > maxScreenSize ? sW : minScreenSize;

    double separador = lerpDouble(10, 16, sW/width);

   return Container(
    child: Column(
      children: [
        Container(height: separador),

        MyRTextFormField(
          hintText: formHintsRegistro[0],
          controller: formControllersRegistro[0],
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          formColor: MyColors().colorGrisClaro()
        ),
        Container(height: separador),

        MyRTextFormField(
          hintText: formHintsRegistro[1],
          controller: formControllersRegistro[1],
          keyboardType: TextInputType.text,
          obscureText: true,
          formColor: MyColors().colorGrisClaro()
        ),
        Container(height: separador),
        
        MyRTextFormField(
          hintText: formHintsRegistro[2],
          controller: formControllersRegistro[2],
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          formColor: MyColors().colorGrisClaro()
        ),
        Container(height: separador),
        
        MyRTextFormField(
          hintText: formHintsRegistro[3],
          controller: formControllersRegistro[3],
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          formColor: MyColors().colorGrisClaro()
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
                    hintText: formHintsRegistro[4],
                    controller: formControllersRegistro[4],
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    formColor: MyColors().colorGrisClaro()
                  ),
                ),
                Container(
                  width: (constraints.maxWidth/2 - separador/2),
                  child: MyRTextFormField(
                    hintText: formHintsRegistro[5],
                    controller: formControllersRegistro[5],
                    keyboardType: TextInputType.phone,
                    obscureText: false,
                    formColor: MyColors().colorGrisClaro()
                  ),
                ),
              ] 
            );
          }
        ),
        Container(height: separador),

        Container(
          constraints: BoxConstraints(minWidth: sW > maxScreenSize ? formW * 1 / 4 : formW * 7/10),
          child: DropdownButton<String>(
            dropdownColor: MyColors().colorGrisClaro(),
            elevation: 0,
            items: <String>['Masculino', 'Femenino']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: MyColors().colorOscuro(),
              fontWeight: FontWeight.w400
            ),
            value: controlSexo,
            hint: MyRText(
              text: "Seleccione su sexo",
              tipo: "bodyLL",
              color: MyColors().colorGris()
            ),
            onChanged: (String newValue) {
              dropDownButton(newValue);
            },
          ),
        ),
      

        Container(height: separador),
        
        MyRTextFormField(
          hintText: formHintsRegistro[7],
          controller: formControllersRegistro[7],
          keyboardType: TextInputType.text,
          obscureText: false,
          formColor: MyColors().colorGrisClaro()
        ),
      ]
    )
  );
 }
}