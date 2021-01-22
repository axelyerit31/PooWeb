import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'baseDatos/bdUsuario.dart';
import 'package:http/http.dart' as http;

double sangria = 10;
double separador = 40;

String rol = "usuario";

var datosPersonales = {
  "nombres": "John Ernesto",
  "apellidos": "Doe Quispe",
  "correo": "johndoe28@gmail.com",
  "sexo" : "hombre",
  "dni": "74056487",
  "celular": "962084579"
};

var datosPlan = {
  "plan": "Inicial",
  "precio": "S/. 29.90",
};

var cita1 = {
  "especialidad": "Endodoncia",
  "fecha": "Dic, 06",
  "hora": "6:40 p.m.",
  "dentista": "Nilton Salinas",
  "costo": "----",
  "estado": "En Espera",
};

var cita2 = {
  "especialidad": "Implante Dental",
  "fecha": "Set, 22",
  "hora": "10:50 a.m.",
  "dentista": "Nilton Salinas",
  "costo": "----",
  "estado": "En Espera",
};

var cita3 = {
  "especialidad": "Limpieza Rutinaria",
  "fecha": "Ago, 30",
  "hora": "5:00 p.m.",
  "dentista": "Nilton Salinas",
  "costo": "0.00",
  "estado": "Faltó",
};

var cita4 = {
  "especialidad": "Endodoncia",
  "fecha": "Ago, 27",
  "hora": "4:30 p.m.",
  "dentista": "Nilton Salinas",
  "costo": "80.00",
  "estado": "Asistió",
};

//metodo para obtenerusuarios

final urlUsuarios = "http://192.168.18.3/PooWeb/verUsuarios.php";

Future<List<Usuario>> obtenerUsuarios() async{
  final resp = await http.get(urlUsuarios);
  return usuarioFromJson( resp.body );
}
