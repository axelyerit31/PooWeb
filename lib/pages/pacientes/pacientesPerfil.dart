import 'package:flutter/material.dart';

import '../maquetaPerfil.dart';
import 'citas.dart';
import 'fichaPersonal.dart';
import 'notificaciones.dart';
import 'planDental.dart';

List<Widget> pantallas = [
  FichaPersonal(),
  Citas(),
  PlanDental(),
  Notificaciones(),
  Container(),
];

List<String> opciones = [
  "Ficha Personal",
  "Cita",
  "Plan Dental",
  "Notificaciones",
  "Editar Perfil",
  "Cerrar Sesión"
];

List<String> iconos = [
  "assets/iconos/perfil.png",
  "assets/iconos/citas.png",
  "assets/iconos/citas.png",
  "assets/iconos/editar_perfil.png",
  "assets/iconos/notificacion.png",
  "assets/iconos/cerrar_sesion.png",
];

class PacientesPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Maqueta(
      rol: "paciente",
      pantallas: pantallas,
      opciones: opciones,
      iconosOpciones: iconos,
    );
  }
}

