// To parse this JSON data, do
//
//     final obtenerUsuarios = obtenerUsuariosFromJson(jsonString);

import 'dart:convert';

List<Usuario> usuarioFromJson(String str) => List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
    Usuario({
        this.identificador,
        this.nombresUsuario,
        this.apellidosUsuario,
        this.telefono,
        this.email,
        this.sexo,
        this.direccion,
    });

    String identificador;
    String nombresUsuario;
    String apellidosUsuario;
    String telefono;
    String email;
    String sexo;
    String direccion;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        identificador: json["dni_usu"],
        nombresUsuario: json["nombres_usu"],
        apellidosUsuario: json["apellidos_usu"],
        telefono: json["telefono_usu"],
        email: json["correo_usu"],
        sexo: json["sexo_usu"],
        direccion: json["direcciona_pac"],
    );

    Map<String, dynamic> toJson() => {
        "dni_usu": identificador,
        "nombres_usu": nombresUsuario,
        "apellidos_usu": apellidosUsuario,
        "telefono_usu": telefono,
        "correo_usu": email,
        "sexo_usu": sexo,
        "direccion_pac": direccion,
    };
}
