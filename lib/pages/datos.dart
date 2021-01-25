
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'baseDatos/bdUsuario.dart';
import 'package:http/http.dart' as http;

double sangria = 10;
double separador = 40;

var planCero = {
  "plan": "Cero",
  "precio": "0.00"
};
var planInicial = {
  "plan": "Inicial",
  "precio": "39.90"
};
var planExperto = {
  "plan": "Experto",
  "precio": "47.90"
};

String rolGlobal = "usuario";

var datosPersonales = {
};

var datosPlan = {
  "plan": "Inicial",
  "precio": "39.90",
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

final urlUsuarios = "http://192.168.18.3/PooWeb/obtenerPacientesUsuarios.php";

Future<List<Usuario>> obtenerUsuarios() async{
  final resp = await http.get(urlUsuarios);
  return usuarioFromJson( resp.body );
}


final urlObtenerPaciente = "http://192.168.18.3/PooWeb/obtenerPaciente.php";

Future<List> obtenerPacienteFicha(String identificador) async{
  final resp = await http.post(urlObtenerPaciente, body: {
    "dni": identificador
  });

  var resultado = jsonDecode(resp.body);

  return resultado;
}

void obtenerPaciente(String identificador) async{
  final resp = await http.post(urlObtenerPaciente, body: {
    "dni": identificador
  });

  var resultado = jsonDecode(resp.body);
  
  datosPersonales = {
    "dni" : resultado[0]["dni"],
    "nombres" : resultado[0]["nombres_usuario"],
    "apellidos" : resultado[0]["apellidos_usuario"],
    "correo" : resultado[0]["email"],
    "celular" : resultado[0]["telefono"],
    "sexo" : resultado[0]["sexo"],
    "direccion" : resultado[0]["direccion"],
  };
}