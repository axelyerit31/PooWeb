import 'dart:convert';
import 'package:http/http.dart' as http;

double sangria = 10;
double separador = 40;
int largoDatosConPlan = 8;

String rolGlobal = "usuario";

//Datos del usuario
var datosPersonales = {};
var datosCitas = [];

//Datos de la pagina web
var datosPlanes = [];
var datosEspecialidades = [];
var listaEspecialidades = [];

final urlHenry = "http://192.168.43.213";
final urlAxel = "http://192.168.18.3";
final url = urlAxel + "/PooWeb/";


final String datos = "";
//URL para obtener datos de MySql
final urlUsuarios = url + "obtenerPacientesUsuarios.php";
final urlObtenerCliente = url + "obtenerCliente.php";
final urlObtenerPaciente = url + "obtenerPaciente.php";
final urlObtenerPersonal = url + "obtenerPersonal.php";
final urlObtenerAdmin = url + "obtenerAdmin.php";
final urlObtenerPlanes = url + "obtenerPlanesDentales.php";
final urlObtenerCitas = url + "obtenerCitas.php";
final urlObtenerCitasLista = url + "obtenerCitasLista.php";
final urlObtenerEspecialidades = url + "obtenerEspecialidades.php";

//URL para insertar datos en MySql
final urlInsertarUsuarioPaciente = url + "insertarUsuarioPaciente.php";
final urlInsertarEspecialidad = url + "insertarEspecialidad.php";
final urlInsertarCita = url + "insertarCita.php";
final urlInsertarCitaLista = url + "insertarCitaLista.php";

//URL para borrar datos de MySql
final urlBorrarCita = url + "borrarCita.php";
final urlBorrarEspecialidad = url + "borrarEspecialidad.php";
final urlBorrarPacienteUsuario = url + "borrarPaciente.php";

//URL para editar datos de MySql
final urlEditarEspecialidad = url + "editarEspecialidad.php";
final urlActualizarPlan = url + "actualizarPlan.php";

//Funciones para obtener datos de MySql

Future<List> obtenerUsuarios() async {
  final resp = await http.get(urlUsuarios);
  return jsonDecode(resp.body);
}

Future<List> obtenerPacienteFicha(String identificador) async {
  final resp =
      await http.post(urlObtenerPaciente, body: {"dni": identificador});

  var resultado = jsonDecode(resp.body);

  return resultado;
}

Future<Map> obtenerCliente(String identificador) async {
  final resp = await http.post(urlObtenerCliente, body: {"dni": identificador});

  var resultado = jsonDecode(resp.body)[0];

  return resultado;
}

void obtenerPaciente(String identificador) async {
  final resp =
      await http.post(urlObtenerPaciente, body: {"dni": identificador});

  var resultado = jsonDecode(resp.body);

  datosPersonales = {
    "dni": resultado[0]["dni_usu"],
    "nombres": resultado[0]["nombres_usu"],
    "apellidos": resultado[0]["apellidos_usu"],
    "correo": resultado[0]["correo_usu"],
    "celular": resultado[0]["telefono_usu"],
    "sexo": resultado[0]["sexo_usu"],
    "direccion": resultado[0]["direccion_pac"],
    "idPlan": resultado[0]["id_plan"],
    "plan": resultado[0]["nombre_plan"],
    "afiliacionPlan": resultado[0]["fecha_afiliacion_plan"],
  };
}

void obtenerPersonal(String identificador) async {
  final resp = await http
      .post(urlObtenerPersonal, body: {"nro_colegiado": identificador});

  var resultado = jsonDecode(resp.body);

  datosPersonales = {
    "nro": resultado[0]["nro_colegiado"],
    "dni": resultado[0]["dni_den"],
    "nombres": resultado[0]["nombres_den"],
    "apellidos": resultado[0]["apellidos_den"],
    "correo": resultado[0]["correo_den"],
    "universidad": resultado[0]["casa_estudio"],
  };
}

void obtenerAdmin(String identificador) async {
  final resp = await http.post(urlObtenerAdmin, body: {"id": identificador});

  var resultado = jsonDecode(resp.body);

  datosPersonales = {
    "id": resultado[0]["id_adm"],
    "nombres": resultado[0]["nombres_adm"],
    "apellidos": resultado[0]["apellidos_adm"],
    "correo": resultado[0]["correo_adm"],
  };
}

void obtenerPlanes() async {
  final resp = await http.post(urlObtenerPlanes);

  var resultado = jsonDecode(resp.body);

  datosPlanes.clear();
  datosPlanes = [
    {
      "id": resultado[0]["id_plan"],
      "plan": resultado[0]["nombre_plan"],
      "costo": resultado[0]["costo_plan"],
    },
    {
      "id": resultado[1]["id_plan"],
      "plan": resultado[1]["nombre_plan"],
      "costo": resultado[1]["costo_plan"],
    },
    {
      "id": resultado[2]["id_plan"],
      "plan": resultado[2]["nombre_plan"],
      "costo": resultado[2]["costo_plan"],
    },
  ];
}

void obtenerCitas() async {
  final resp =
      await http.post(urlObtenerCitas, body: {"dni": datosPersonales["dni"]});

  var resultado = jsonDecode(resp.body);

  datosCitas.clear();
  for (var i = 0; i < resultado.length; i++) {
    datosCitas.add({
      "id": resultado[i]["id_cita"],
      "especialidad": resultado[i]["id_esp"],
      "generado": resultado[i]["fecha_gen_cita"],
      "fecha": resultado[i]["fecha_cita"],
      "hora": resultado[i]["hora_cita"],
      "estado": resultado[i]["estado_cita"],
    });
  }
}

Future<List> obtenerCitasFuture() async {
  final resp =
      await http.post(urlObtenerCitas, body: {"dni": datosPersonales["dni"]});

  var resultado = jsonDecode(resp.body);

  return resultado;
}

Future<List> obtenerCitasLista() async {
  final resp = await http.post(urlObtenerCitasLista);

  final respuesta = jsonDecode(resp.body);
  return respuesta;
}

void obtenerEspecialidades() async {
  final res = await http.post(urlObtenerEspecialidades);

  final u = jsonDecode(res.body);

  datosEspecialidades.clear();
  listaEspecialidades.clear();
  for (var i = 0; i < u.length; i++) {
    datosEspecialidades.add({
      "id": u[i]["id_esp"],
      "nombre": u[i]["nombre_esp"],
      "descripcion": u[i]["descripcion_esp"],
    });
    listaEspecialidades.add(u[i]["nombre_esp"]);
  }
}

Future<List> obtenerEspecialiadesFuture() async {
  final res = await http.post(urlObtenerEspecialidades);

  final u = jsonDecode(res.body);

  return u;
}

//Funciones para insertar datos en MySql

//Funcion para convertir usuario en paciente
void insertarUsuarioPaciente(
    String dni, String direccion, String contrasena) async {
  http.post(urlInsertarUsuarioPaciente, body: {
    "dni": dni,
    "direccion": direccion,
    "contrasena": contrasena,
  });
}

void insertarEspecialidad(String nombre, String descripcion) async {
  http.post(urlInsertarEspecialidad, body: {
    "nombre": nombre,
    "descripcion": descripcion,
  });
}

//Funciones para eliminar datos de MySql

void borrarCita(int id) async {
  http.post(urlBorrarCita, body: {"id_cita": id.toString()});
}

void borrarEspecialidad(String id) async {
  http.post(urlBorrarEspecialidad, body: {"id_esp": id});
}

//Funcion para borrar a usuario o paciente
void borrarPacienteUsuario(String id) async {
  http.post(urlBorrarPacienteUsuario, body: {"dni": id});
}

//Funcion para editar datos de MySql
void editarEspecialidad(String id, String nombre, String descripcion) async {
  http.post(urlEditarEspecialidad, body: {
    "id_esp": id,
    "nombre_esp": nombre,
    "descripcion_esp": descripcion
  });
}

void editarActualizarPlan(String id, String dni, String afiliacion) async {
  http.post(urlActualizarPlan,
      body: {"id_plan": id, "dni_pac": dni, "afiliacion": afiliacion});
}
