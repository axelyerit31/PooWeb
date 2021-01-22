import 'package:flutter/material.dart';
import 'package:poo_web/pages/datos.dart';

import '../../myWidgets.dart';
import '../../mystyle.dart';
import '../maquetaPerfil.dart';
import 'fichaPersonal.dart';

class Citas extends StatefulWidget {
  @override
  _CitasState createState() => _CitasState();
}

double _alturaImagen = 250;

class _CitasState extends State<Citas> {
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
                text: "+ Agregar Cita",
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
            PlanDentalFicha()
          ],
        )
      ],
    ),
  );
}


List citas = [
  cita1,
  cita2,
  cita3,
  cita4
];

class TablaCitas extends StatefulWidget {
  @override
  _TablaCitasState createState() => _TablaCitasState();
}

class _TablaCitasState extends State<TablaCitas> {

  void rowSelected(int indice, bool selected){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return rowAlert(indice, selected);
      }
    );
  }

  Color colorSeparador = Colors.transparent;
  double anchoSeparador = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTable(
        showCheckboxColumn: false,
        dividerThickness: 2,
        sortColumnIndex: 0,
        sortAscending: true,
        columnSpacing: 30,
        horizontalMargin: 0,
        columns: [
          DataColumn(label: Container(width: anchoSeparador, color: colorSeparador)),
          DataColumn(label: MyRText(text: "Especialidad", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
          DataColumn(label: MyRText(text: "Fecha", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
          DataColumn(label: MyRText(text: "Hora", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
          DataColumn(label: MyRText(text: "Dentista", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
          DataColumn(label: MyRText(text: "Costo", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6), numeric: true),
          DataColumn(label: MyRText(text: "Estado", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
          DataColumn(label: Container(width: anchoSeparador, color: colorSeparador)),
        ],
        rows: [
          for (var i = 0; i < citas.length; i++)
            DataRow(
              onSelectChanged: (selected) {
                if(selected){
                  rowSelected(i, selected);
                }
              },
              cells: [
                DataCell(Container(width: anchoSeparador, color: colorSeparador)),
                DataCell(MyRText(text: "${citas[i]["especialidad"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(MyRText(text: "${citas[i]["fecha"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(MyRText(text: "${citas[i]["hora"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(MyRText(text: "${citas[i]["dentista"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(MyRText(text: "S/. ${citas[i]["costo"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(MyRText(text: "${citas[i]["estado"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(Container(width: anchoSeparador, color: colorSeparador)),
              ]
            ),
          for (var i = 0; i < citas.length; i++)
            DataRow(
              cells: [
                DataCell(Container(width: anchoSeparador, color: colorSeparador)),
                DataCell(MyRText(text: "${citas[i]["especialidad"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(MyRText(text: "${citas[i]["fecha"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(MyRText(text: "${citas[i]["hora"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(MyRText(text: "${citas[i]["dentista"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(MyRText(text: "S/. ${citas[i]["costo"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(MyRText(text: "${citas[i]["estado"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                DataCell(Container(width: anchoSeparador, color: colorSeparador)),
              ]
            ),
        ],
      )
    );
  }

  

  AlertDialog rowAlert(int indice, bool selected){
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyRText(text: "¿Que acción desea Realizar?", tipo: "body", color: MyColors().colorOscuro(), bold: 6),
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
      content: MyRText(
        text: "Las acciones que realice no podrán deshacerse.",
        tipo: "bodyLL", color: MyColors().colorAzulMedio(),
        bold: 5
      ),
      actions: [
        MyROutlineButton(
          onPressed: () {
            if(selected){
              setState(() {
                citas.removeAt(indice);
              });
            }
            Navigator.pop(context);
          },
          color: MyColors().colorOscuro(),
          child: MyRText(text: "Eliminar Cita", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)
        ),
        MyRButton(
          onPressed: () {},
          child: MyRText(text: "Postergar Cita", tipo: "bodyLLL", color: Colors.white, bold: 5))
      ],
    );
  }
}