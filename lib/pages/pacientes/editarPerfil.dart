import 'package:flutter/material.dart';
import 'package:poo_web/mystyle.dart';
import 'package:poo_web/pages/datos.dart';

import 'package:http/http.dart' as http;
import 'package:poo_web/pages/usuarios/login.dart';
import 'package:poo_web/pages/usuarios/registro.dart';
import '../../myWidgets.dart';
import '../maquetaPerfil.dart';

var urlEditarPaciente = url + "editarPaciente.php";

TextEditingController _controlNombres = new TextEditingController();
TextEditingController _controlApellidos = new TextEditingController();
TextEditingController _controlCorreo = new TextEditingController();
TextEditingController _controlContrasena = new TextEditingController();
TextEditingController _controlConfirmarContrasena = new TextEditingController();
TextEditingController _controlCelular = new TextEditingController();
TextEditingController _controlDireccion = new TextEditingController();

Future<List> editarPaciente() async {
  http.post(urlEditarPaciente, body: {
    "dniAntiguo": datosPersonales["dni"],
    "dniNuevo": datosPersonales["dni"],
    "nombres": _controlNombres.text,
    "apellidos": _controlApellidos.text,
    "correo": _controlCorreo.text,
    "contrasena": _controlContrasena.text,
    "direccion": _controlDireccion.text,
    "telefono": _controlCelular.text,
    "sexo": datosPersonales["sexo"]
  });
}

List<TextEditingController> _formControllers;
List<String> _formHints;
List<String> _formInitial;
List<TextInputType> _formKeyboard;

class EditarPerfil extends StatelessWidget {
  final ValueChanged<int> state;

  const EditarPerfil({this.state});

  @override
  Widget build(BuildContext context) {
    _formControllers = [
      _controlNombres,
      _controlApellidos,
      _controlCorreo,
      _controlContrasena,
      _controlConfirmarContrasena,
      _controlCelular,
      _controlDireccion
    ];

    _formHints = [
      datosPersonales["nombres"],
      datosPersonales["apellidos"],
      datosPersonales["correo"],
      "Nueva contraseña",
      "Confirme su contraseña",
      datosPersonales["celular"],
      datosPersonales["direccion"],
    ];

    _formInitial = [
      datosPersonales["nombres"],
      datosPersonales["apellidos"],
      datosPersonales["correo"],
      "",
      "",
      datosPersonales["celular"],
      datosPersonales["direccion"],
    ];

    _formKeyboard = [
      TextInputType.text,
      TextInputType.text,
      TextInputType.emailAddress,
      TextInputType.text,
      TextInputType.text,
      TextInputType.phone,
      TextInputType.text,
    ];

    double sW = MediaQuery.of(context).size.width;

    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(height: 520, width: sW / 4, child: perfil()),
        SizedBox(width: separador),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 350, child: _forms()),
            MyRButton(
                onPressed: () {
                  for (var i = 0; i < _formControllers.length; i++) {
                    if (_formControllers[i].text == "") {
                      _formControllers[i].text = _formInitial[i];
                      print("El form ${_formHints[i]} esta en blanco");
                    }
                  }
                  if (_formControllers[3].text == "" &&
                      _formControllers[4].text == "") {
                    _formControllers[3].text = null;
                    _formControllers[4].text = null;
                  }
                  if (_controlContrasena.text ==
                      _controlConfirmarContrasena.text) {
                    editarPaciente();
                    obtenerPaciente(datosPersonales["dni"]);
                    datosPersonales = {
                      "nombres": _controlNombres.text,
                      "apellidos": _controlApellidos.text,
                      "correo": _controlCorreo.text,
                      "direccion": _controlDireccion.text,
                      "celular": _controlCelular.text,
                    };
                    for (var i = 0; i < _formControllers.length; i++) {
                      print("Se limpio _${_formControllers[i].text}");
                      _formControllers[i].clear();
                    }
                    rowAlert("El cambio de datos se realizó exitosamente.",
                        context, "¡Hecho!", "Ir a Ficha Personal", () {
                      Navigator.pop(context);
                      state(3);
                      state(0);
                    });
                  } else {
                    rowAlert(
                        "Las contraseñas ingresadas no coinciden", context);
                  }
                },
                child: MyRText(
                    text: "Guardar",
                    color: Colors.white,
                    tipo: "buttonContent",
                    bold: 5))
          ],
        ),
      ],
    ));
  }
}

Widget _forms() {
  return Column(
    children: [
      for (var i = 0; i < _formControllers.length; i++)
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: MyRTextFormField(
            controller: _formControllers[i],
            hintText: _formHints[i],
            textColor: MyColors().colorGris(),
            formColor: Colors.white,
            obscureText: i == 3 || i == 4 ? true : false,
            keyboardType: _formKeyboard[i],
          ),
        )
    ],
  );
}
