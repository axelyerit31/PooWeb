import 'package:flutter/material.dart';
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
        _header(),
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

Widget _header(){
  return Container(
    alignment: Alignment.center,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.red,
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