import 'package:flutter/material.dart';
import 'package:poo_web/pages/personal/pacientes.dart';

import '../maquetaPerfil.dart';

List<String> opciones = [
  "Perfil",
  "Citas",
  "Pacientes",
  "Especialidades",
  "Editar Perfil",
  "Cerrar Sesión"
];

List<String> iconos = [
  "assets/iconos/perfil.png",
  "assets/iconos/citas.png",
  "assets/iconos/citas.png",
  "assets/iconos/notificacion.png",
  "assets/iconos/editar_perfil.png",
  "assets/iconos/cerrar_sesion.png",
];

class PersonalPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Maqueta(
      rol: "personal",
      opciones: opciones,
      iconosOpciones: iconos,
    );
  }
}

