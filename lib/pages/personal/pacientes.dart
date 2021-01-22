import 'package:flutter/material.dart';
import 'package:poo_web/pages/baseDatos/bdUsuario.dart';
import 'package:poo_web/pages/pacientes/fichaPersonal.dart';

import '../../mystyle.dart';
import '../datos.dart';
import '../maquetaPerfil.dart';


class Pacientes extends StatefulWidget {
  @override
  _PacientesState createState() => _PacientesState();
}

double _alturaImagen = 250;

class _PacientesState extends State<Pacientes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: separador),
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
            SizedBox(height: sangria/2),
            Container(
              height: 209,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(roundedB),
                color: Colors.white
              ),
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: SingleChildScrollView(child: TablaCitas())
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
  double anchoSeparador = 0;

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
              columnSpacing: 30,
              horizontalMargin: 0,
              columns: [
                DataColumn(label: Container(width: anchoSeparador, color: colorSeparador)),
                DataColumn(label: MyRText(text: "DNI", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Nombres", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Apellidos", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Teléfono", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6), numeric: true),
                DataColumn(label: MyRText(text: "Email", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Sexo", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: Container(width: anchoSeparador, color: colorSeparador)),
              ],
              rows: [
                for (var i = 0; i < 8; i++)
                  DataRow(
                    cells: [
                      DataCell(Container(width: anchoSeparador, color: colorSeparador)),
                      DataCell(MyRText(text: "${snapshot.data[i].identificador}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[i].nombresUsuario}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[i].apellidosUsuario}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[i].telefono}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[i].email}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[i].sexo}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
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