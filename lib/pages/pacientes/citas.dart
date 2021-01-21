import 'package:flutter/material.dart';
import 'package:poo_web/pages/datos.dart';

import '../../mystyle.dart';
import 'fichaPersonal.dart';

class Citas extends StatefulWidget {
  @override
  _CitasState createState() => _CitasState();
}

class _CitasState extends State<Citas> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(roundedB),
              color: Colors.white
            ),
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(child: _citas())
          ),
        ),
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
          height: 250,
          width: 190,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePerfilCerca),
              fit: BoxFit.contain
            )
          ),
        ),
        SizedBox(width: separador),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Datos(),
            SizedBox(height: separador),
            PlanDentalFicha()
          ],
        )
      ],
    ),
  );
}

Widget _citas(){
  return Container(
    child: DataTable(
      sortColumnIndex: 0,
      sortAscending: true,
      columnSpacing: 30,
      horizontalMargin: 0,
      columns: [
        DataColumn(label: MyRText(text: "Especialidad", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
        DataColumn(label: MyRText(text: "Fecha", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
        DataColumn(label: MyRText(text: "Hora", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
        DataColumn(label: MyRText(text: "Dentista", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
        DataColumn(label: MyRText(text: "Costo", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6), numeric: true),
        DataColumn(label: MyRText(text: "Estado", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
      ],
      rows: [
        for (var i = 0; i < citas.length; i++)
          DataRow(
            cells: [
              DataCell(MyRText(text: "${citas[i]["especialidad"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
              DataCell(MyRText(text: "${citas[i]["fecha"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
              DataCell(MyRText(text: "${citas[i]["hora"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
              DataCell(MyRText(text: "${citas[i]["dentista"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
              DataCell(MyRText(text: "S/. ${citas[i]["costo"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
              DataCell(MyRText(text: "${citas[i]["estado"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
            ]
          ),
        for (var i = 0; i < citas.length; i++)
          DataRow(
            cells: [
              DataCell(MyRText(text: "${citas[i]["especialidad"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
              DataCell(MyRText(text: "${citas[i]["fecha"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
              DataCell(MyRText(text: "${citas[i]["hora"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
              DataCell(MyRText(text: "${citas[i]["dentista"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
              DataCell(MyRText(text: "S/. ${citas[i]["costo"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
              DataCell(MyRText(text: "${citas[i]["estado"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
            ]
          ),
      ],
    )
  );
}