import 'package:flutter/material.dart';
import 'package:poo_web/pages/datos.dart';

import '../../myWidgets.dart';
import '../../mystyle.dart';
import 'clientes.dart';

class EspecialidadesPersonal extends StatelessWidget {

  final ValueChanged<int> state;
  const EspecialidadesPersonal({this.state});

  @override
  Widget build(BuildContext context) {

    print("Se cargo EspecialidadesPersonal");

    return Container(
      child: Column(
        children: [
          header(),
          SizedBox(height: 20),
          TextButton(
            onPressed: (){
              editarEspecialidadAlert("", "", "", "Agregar", context, state);
            },
            child: MyRText(
              text: "+ Agregar Especialidad",
              tipo: "bodyB",
              color: MyColors().colorAzulClaro(),
              bold: 6
            )
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(roundedB),
              color: Colors.white
            ),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: SingleChildScrollView(child: TablaEspecialidades(state: state))
          ),
        ],
      )
    );
  }
}

class TablaEspecialidades extends StatelessWidget {
  
  final ValueChanged<int> state;

  const TablaEspecialidades({this.state});

  @override
  Widget build(BuildContext context) {

    
  Color colorSeparador = Colors.transparent;
  double anchoSeparador = 15;

    return Container(
      child: FutureBuilder(
        future: obtenerEspecialiadesFuture(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return DataTable(
              dataRowHeight: 70,
              showCheckboxColumn: false,
              dividerThickness: 2,
              sortColumnIndex: 0,
              sortAscending: true,
              columnSpacing: 20,
              horizontalMargin: 0,
              columns: [
                DataColumn(label: Container(width: anchoSeparador, color: colorSeparador)),
                DataColumn(label: MyRText(text: "Nombre", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Descripción", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: Container(width: anchoSeparador, color: colorSeparador)),
              ],
              rows: [
                for (var i = 0; i < snapshot.data.length; i++)
                  DataRow(
                    onSelectChanged: (selected){
                      rowAlert(
                        "${snapshot.data[i]["descripcion_esp"]}",  context,
                        "${snapshot.data[i]["nombre_esp"]}",
                        "Editar",
                        (){
                          Navigator.pop(context);
                          editarEspecialidadAlert(snapshot.data[i]["id_esp"], snapshot.data[i]["nombre_esp"], snapshot.data[i]["descripcion_esp"], "Editar", context, state);
                        },
                        rolGlobal == "admin",
                        "Eliminar",
                        (){
                          Navigator.pop(context);
                          rowAlert(
                            "¿Está seguro que desea eliminar esta especialidad?", context,
                            "Eliminar ${snapshot.data[i]["nombre_esp"]}",
                            "Eliminar",
                            (){
                              Navigator.pop(context);
                              borrarEspecialidad(snapshot.data[i]["id_esp"]);
                              rowAlert("La especialidad se eliminó exitosamente.", context, "¡Hecho!");
                              state(3);
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
                      DataCell(MyRText(text: "${snapshot.data[i]["nombre_esp"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[i]["descripcion_esp"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
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




//Alerta para mostrar cuando un usuario se convierta en paciente
AlertDialog editarEspecialidadAlert(String id, String nombre, String descripcion, String accion, BuildContext context, ValueChanged<int> state){
  
  showDialog(
    context: context,
    builder: (BuildContext context){
      
      TextEditingController _controlNombreEsp = TextEditingController(text: nombre);
      TextEditingController _controlDescripcionEsp = TextEditingController(text: descripcion);

      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 300,
              child: MyRTextFormField(
                textColor: MyColors().colorGris(),
                hintText: "Nombre",
                controller: _controlNombreEsp,
                keyboardType: TextInputType.text,
                obscureText: false,
                formColor: MyColors().colorClaro()
              ),
            ),
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
        content: Container(
          width: 300,
          child: MyRTextFormField(
            maxLines: 5,
            textColor: MyColors().colorGris(),
            hintText: "Descripción",
            controller: _controlDescripcionEsp,
            keyboardType: TextInputType.text,
            obscureText: false,
            formColor: MyColors().colorClaro()
          ),
        ),
        actions: [
          MyRButton(
            onPressed: () {
              if(accion == "Editar"){
                if(_controlNombreEsp.text != "" && _controlDescripcionEsp.text != ""){
                  editarEspecialidad(id, _controlNombreEsp.text, _controlDescripcionEsp.text);
                  Navigator.pop(context);
                  state(3);
                  _controlDescripcionEsp.clear();
                  _controlNombreEsp.clear();
                  rowAlert("La especialidad se editó exitosamente.", context, "¡Hecho!");
                }else{
                  rowAlert("Asegúrese de llenar todos los campos.", context);
                }
              }else if(accion == "Agregar"){
                if(_controlNombreEsp.text != "" && _controlDescripcionEsp.text != ""){
                  insertarEspecialidad(_controlNombreEsp.text, _controlDescripcionEsp.text);
                  Navigator.pop(context);
                  state(3);
                  _controlDescripcionEsp.clear();
                  _controlNombreEsp.clear();
                  rowAlert("La especialidad se agregó exitosamente.", context, "¡Hecho!");
                }else{
                  rowAlert("Asegúrese de llenar todos los campos.", context);
                }
              }
              
            },
            child: MyRText(text: accion, tipo: "bodyLLL", color: Colors.white, bold: 5)
          )
        ],
      );
    }
  );
}