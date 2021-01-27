import 'package:flutter/material.dart';
import 'package:poo_web/myWidgets.dart';
import 'package:poo_web/pages/baseDatos/bdUsuario.dart';
import 'package:poo_web/pages/pacientes/fichaPersonal.dart';

import '../../mystyle.dart';
import '../datos.dart';
import '../maquetaPerfil.dart';


class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

double _alturaImagen = 250;

class _ClientesState extends State<Clientes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: separador/2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyRText(
                        text: "Paciente: ",
                        tipo: "bodyLL",
                        color: MyColors().colorOscuro(),
                        bold: 6
                      ),
                      MyRText(
                        text: "Clientes registrados.",
                        tipo: "bodyLL",
                        color: MyColors().colorAzulMedio(),
                        bold: 4
                      ),
                      SizedBox(width: separador),
                      MyRText(
                        text: "Usuario: ",
                        tipo: "bodyLL",
                        color: MyColors().colorOscuro(),
                        bold: 6
                      ),
                      MyRText(
                        text: "Clientes no registrados.",
                        tipo: "bodyLL",
                        color: MyColors().colorAzulMedio(),
                        bold: 4
                      ),
                    ]
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 6
                      ),
                      primary: Colors.white
                    ),
                    onPressed: () {},
                    child: MyRText(
                      text: "+ Agregar Paciente",
                      tipo: "bodyLL",
                      color: MyColors().colorOscuro(),
                      bold: 6
                    )
                  ),
                ],
              ),
            ),
            SizedBox(height: separador/5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(roundedB),
                    color: Colors.white
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: SingleChildScrollView(child: TablaCitas())
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

Widget header(){
  return Container(
    alignment: Alignment.center,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: _alturaImagen,
          width: 190,
          child: perfilCerca()
        ),
        SizedBox(width: separador),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Datos(),
            SizedBox(height: separador),
          ],
        )
      ],
    ),
  );
}

class TablaCitas extends StatefulWidget {
  @override
  _TablaCitasState createState() => _TablaCitasState();
}

class _TablaCitasState extends State<TablaCitas> {

  Color colorSeparador = Colors.transparent;
  double anchoSeparador = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: obtenerUsuarios(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return DataTable(
              showCheckboxColumn: false,
              dividerThickness: 2,
              sortColumnIndex: 0,
              sortAscending: true,
              columnSpacing: 20,
              horizontalMargin: 0,
              columns: [
                DataColumn(label: Container(width: anchoSeparador, color: colorSeparador)),
                DataColumn(label: MyRText(text: "Calidad", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "DNI", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Nombres", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Apellidos", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Teléfono", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6), numeric: true),
                DataColumn(label: MyRText(text: "Email", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Sexo", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Dirección", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: Container(width: anchoSeparador, color: colorSeparador)),
              ],
              rows: [
                for (var i = 0; i < snapshot.data[1].length; i++)
                  DataRow(
                    onSelectChanged: (selected){
                    },
                    cells: [
                      DataCell(Container(width: anchoSeparador, color: colorSeparador)),
                      DataCell(MyRText(text: "Paciente", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 6)),
                      DataCell(MyRText(text: "${snapshot.data[1][i]["dni_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[1][i]["nombres_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[1][i]["apellidos_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[1][i]["telefono_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[1][i]["correo_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[1][i]["sexo_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[1][i]["direccion_pac"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(Container(width: anchoSeparador, color: colorSeparador)),
                    ]
                  ),
                for (var i = 0; i < snapshot.data[0].length; i++)
                  DataRow(
                    onSelectChanged: (selected){
                      rowAlert(
                        "¿Qué acción desea realizar con el usuario?",  context,
                        "${snapshot.data[0][i]["nombres_usu"]}",
                        "Convertir a Paciente",
                        (){
                          Navigator.pop(context);
                          usuarioAlert(snapshot.data[0][i]["nombres_usu"], snapshot.data[0][i]["dni_usu"], context);
                        },
                        rolGlobal == "admin",
                        "Eliminar",
                        (){
                          Navigator.pop(context);
                          rowAlert(
                            "¿Está seguro que desea eliminar este usuario?", context,
                            "Eliminar a ${snapshot.data[0][i]["nombres_usu"]}",
                            "Eliminar",
                            (){
                              borrarPacienteUsuario(snapshot.data[i]["dni_usu"]);
                              rowAlert("El usuario se eliminó exitosamente.", context, "¡Hecho!");
                            },
                            true,
                            "Cancelar",
                            (){
                              Navigator.pop(context);
                            }
                          );
                        }
                      );
                    },
                    cells: [
                      DataCell(Container(width: anchoSeparador, color: colorSeparador)),
                      DataCell(MyRText(text: "Usuario", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 6)),
                      DataCell(MyRText(text: "${snapshot.data[0][i]["dni_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[0][i]["nombres_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[0][i]["apellidos_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[0][i]["telefono_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[0][i]["correo_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[0][i]["sexo_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "No registrado", tipo: "bodyLLL", color: MyColors().colorGris(), bold: 5)),
                      DataCell(Container(width: anchoSeparador, color: colorSeparador)),
                    ]
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}


TextEditingController _controlDireccion = TextEditingController();
TextEditingController _controlContrasena = TextEditingController();


//Alerta para mostrar cuando un usuario se convierta en paciente
AlertDialog usuarioAlert(String nombres, String dni, BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyRText(text: "Hola, $nombres", tipo: "bodyB", color: MyColors().colorOscuro(), bold: 6),
            Transform.translate(
              offset: Offset(20, -20),
              child: Container(
                child: IconButton(
                  splashRadius: 15,
                  icon: Icon(Icons.close, color: MyColors().colorAzulMedio()),
                  onPressed: () {
                    Navigator.pop(context);
                  }
                ),
              ),
            )
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyRText(
              text: "Gracias por unirte a nuestro equipo, ingresa estos\ndatos y bienvenido a Sonríamos Juntos.",
              tipo: "bodyLL", color: MyColors().colorAzulMedio(),
              bold: 5
            ),
            SizedBox(height: separador/2,),
            MyRTextFormField(
              textColor: MyColors().colorGris(),
              hintText: "Dirección",
              controller: _controlDireccion,
              keyboardType: TextInputType.text,
              obscureText: false,
              formColor: MyColors().colorGrisClaro()
            ),
            SizedBox(height: separador/4,),
            MyRTextFormField(
              textColor: MyColors().colorGris(),
              hintText: "Contraseña",
              controller: _controlContrasena,
              keyboardType: TextInputType.text,
              obscureText: true,
              formColor: MyColors().colorGrisClaro()
            ),
          ],
        ),
        actions: [
          MyRButton(
            onPressed: () {
              if(_controlDireccion.text != "" && _controlContrasena.text != ""){
                insertarUsuarioPaciente(dni, _controlDireccion.text, _controlContrasena.text);
                Navigator.pop(context);
                _controlContrasena.clear();
                _controlDireccion.clear();
                rowAlert("El registro se realizó exitosamente.", context, "¡Hecho!");
              }else{
                rowAlert("$nombres asegúrese de llenar todos los campos.", context);
              }
            },
            child: MyRText(text: "Registrarme", tipo: "bodyLLL", color: Colors.white, bold: 5)
          )
        ],
      );
    }
  );
}