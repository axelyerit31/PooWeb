import 'package:flutter/material.dart';
import 'package:poo_web/myWidgets.dart';
import 'package:poo_web/pages/baseDatos/bdUsuario.dart';
import 'package:poo_web/pages/pacientes/fichaPersonal.dart';


import '../../mystyle.dart';
import '../datos.dart';
import '../maquetaPerfil.dart';

//Funcion para obtener fecha y meterlas en un lista
List<int> obtenerFecha(String dato, String separador){
  List<int> lista = [];
  int ultimoIndice = 0;

  for (var i = 0; i < dato.length; i++) {
    if(dato.substring(i, i+1) == separador || i == dato.length-1){
      if(i == dato.length-1) {i+=1;}
      lista.add(int.parse(dato.substring(ultimoIndice, i)));
      ultimoIndice = i+1;
    }
  }
  return lista;
}


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
            //_DatosCliente(),
            SizedBox(height: separador),
          ],
        )
      ],
    ),
  );
}

class _DatosCliente extends StatelessWidget {

  DateTime hoy = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: obtenerCitasLista(),
      builder: (context, snapshot){
        if(snapshot.hasError) {print(snapshot.error);}
        if(snapshot.hasData){

          String fechaCitaDespues;
          String horaCitaDespues;
          String fechaCitaAntes;
          String horaCitaAntes;
          DateTime hoy = DateTime.now();
          DateTime citaFechaAntes;
          DateTime citaFechaDespues;

          for (var i = 0; i < snapshot.data.length; i++) {

            fechaCitaDespues = snapshot.data[i]["fecha_cita"];
            horaCitaDespues = snapshot.data[i]["fecha_cita"];

            fechaCitaAntes = snapshot.data[i+1]["fecha_cita"];
            horaCitaAntes = snapshot.data[i+1]["fecha_cita"];

            citaFechaAntes = DateTime(
              obtenerFecha(fechaCitaAntes, "-")[0],
              obtenerFecha(fechaCitaAntes, "-")[1],
              obtenerFecha(fechaCitaAntes, "-")[2],
              obtenerFecha(horaCitaAntes, ":")[0],
              obtenerFecha(horaCitaAntes, ":")[1]
            );

            citaFechaDespues = DateTime(
              obtenerFecha(fechaCitaAntes, "-")[0],
              obtenerFecha(fechaCitaAntes, "-")[1],
              obtenerFecha(fechaCitaAntes, "-")[2],
              obtenerFecha(horaCitaAntes, ":")[0],
              obtenerFecha(horaCitaAntes, ":")[1]
            );

            if (hoy.isAfter(citaFechaAntes) && hoy.isBefore(citaFechaDespues)){
              return FutureBuilder(
                future: obtenerCliente(snapshot.data[i]["dni_usu"]),
                builder: (context, snapshot2){
                  if(snapshot2.hasError){print(snapshot2.error);}
                  return !snapshot2.hasData
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyRText(text: "Cliente Actual", tipo: "subtitleL", bold: 7, color: MyColors().colorOscuro()),
                          Padding(
                            padding: EdgeInsets.only(left: sangria),
                            child: MyRText(text: "${snapshot2.data[0]["nombres_usu"]} ${snapshot2.data[0]["apellidos_usu"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: sangria),
                            child: MyRText(text: "${snapshot2.data[0]["correo_usu"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: sangria),
                            child: Row(
                              children: [
                                MyRText(text: "DNI: ", tipo: "bodyL", bold: 6, color: MyColors().colorOscuro()),
                                MyRText(text: "${snapshot2.data[0]["dni_usu"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: sangria),
                            child: Row(
                              children: [
                                MyRText(text: "Celular: ", tipo: "bodyL", bold: 6, color: MyColors().colorOscuro()),
                                MyRText(text: "${snapshot2.data[0]["telefono_usu"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
                              ],
                            ),
                          ),
                          if(snapshot2.data.length > 6)
                            Padding(
                              padding: EdgeInsets.only(left: sangria),
                              child: Row(
                                children: [
                                  MyRText(text: "Dirección: ", tipo: "bodyL", bold: 6, color: MyColors().colorOscuro()),
                                  MyRText(text: "${snapshot2.data[0]["direccion_pac"]}", tipo: "bodyL", bold: 5, color: MyColors().colorAzulMedio()),
                                ],
                              ),
                            ),
                        ],
                      );
                }
              );
              
            }else{
              print(false);
            }
          }
        }else{
          return Container();
        }
      },
    );
  }
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
                              borrarPacienteUsuario(snapshot.data[0][i]["dni_usu"]);
                              print(snapshot.data[0][i]["dni_usu"]);
                              Navigator.pop(context);
                              rowAlert("El usuario se eliminó exitosamente.", context, "¡Hecho!");
                              obtenerUsuarios();
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
                obtenerUsuarios();
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