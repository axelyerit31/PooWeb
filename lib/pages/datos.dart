
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'baseDatos/bdUsuario.dart';
import 'package:http/http.dart' as http;

double sangria = 10;
double separador = 40;

String rolGlobal = "usuario";

//Datos del usuario
var datosPersonales = {};
var datosCitas = [];

//Datos de la pagina web
var datosPlanes = [];
var datosEspecialidades = [];

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
final urlObtenerPaciente = "http://192.168.18.3/PooWeb/obtenerPaciente.php";
final urlObtenerPlanes = "http://192.168.18.3/PooWeb/obtenerPlanesDentales.php";
final urlObtenerCitas  = "http://192.168.18.3/PooWeb/obtenerCitas.php";
final urlObtenerEspecialidades = "http://192.168.18.3/PooWeb/obtenerEspecialidades.php";


Future<List<Usuario>> obtenerUsuarios() async{
  final resp = await http.get(urlUsuarios);
  return usuarioFromJson( resp.body );
}

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
    "dni" : resultado[0]["dni_usu"],
    "nombres" : resultado[0]["nombres_usu"],
    "apellidos" : resultado[0]["apellidos_usu"],
    "correo" : resultado[0]["correo_usu"],
    "celular" : resultado[0]["telefono_usu"],
    "sexo" : resultado[0]["sexo_usu"],
    "direccion" : resultado[0]["direccion_pac"],
    "idPlan" : resultado[0]["id_plan"],
    "plan" : resultado[0]["nombre_plan"],
    "afiliacionPlan" : resultado[0]["fecha_afiliacion_plan"],
  };
}

void obtenerPlanes() async{
  final resp = await http.post(urlObtenerPlanes);

  var resultado = jsonDecode(resp.body);
  
  datosPlanes = [
    {
      "plan" : resultado[0]["nombre_plan"],
      "costo" : resultado[0]["costo_plan"],
    },
    {
      "plan" : resultado[1]["nombre_plan"],
      "costo" : resultado[1]["costo_plan"],
    },
    {
      "plan" : resultado[2]["nombre_plan"],
      "costo" : resultado[2]["costo_plan"],
    },
  ];
}

void obtenerCitas() async{
  final resp = await http.post(urlObtenerCitas, body: {
    "dni": datosPersonales["dni"]
  });

  var resultado = jsonDecode(resp.body);
  
  for (var i = 0; i < resultado.length; i++) {
    datosCitas.add(
      {
        "id" : resultado[i]["id_cita"],
        "especialidad" : resultado[i]["id_esp"],
        "generado" : resultado[i]["fecha_gen_cita"],
        "fecha" : resultado[i]["fecha_cita"],
        "hora" : resultado[i]["hora_cita"],
        "estado" : resultado[i]["estado_cita"],
      }
    );
  }
}

void obtenerEspecialidades() async{
  final res = await http.post(urlObtenerEspecialidades);
  
  final u = jsonDecode(res.body);
  for (var i = 0; i < u.length; i++) {
    datosEspecialidades.add({
      "id" : u[i]["id_esp"],
      "nombre" : u[i]["nombre_esp"],
      "descripcion" : u[i]["descripcion_esp"],
    });
  }
}