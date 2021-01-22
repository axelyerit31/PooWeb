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
    });

    String identificador;
    String nombresUsuario;
    String apellidosUsuario;
    String telefono;
    String email;
    String sexo;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        identificador: json["identificador"],
        nombresUsuario: json["nombres_usuario"],
        apellidosUsuario: json["apellidos_usuario"],
        telefono: json["telefono"],
        email: json["email"],
        sexo: json["sexo"],
    );

    Map<String, dynamic> toJson() => {
        "identificador": identificador,
        "nombres_usuario": nombresUsuario,
        "apellidos_usuario": apellidosUsuario,
        "telefono": telefono,
        "email": email,
        "sexo": sexo,
    };
}
