import 'package:flutter/material.dart';
import 'package:poo_web/pages/datos.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import '../../mystyle.dart';
import '../../myWidgets.dart';
import '../maquetaPerfil.dart';
import 'perfilDentista.dart';


String _controlEspecialidad;

//Controllers que mostraran la fecha en los forms
TextEditingController _controlFecha = new TextEditingController();
TextEditingController _controlHora = new TextEditingController();

//Variables que almacenaran las fechas correctamente formateadas para MySql
String _controlEnvioFecha;
String _controlEnvioHora;
String _controlEnvioGenCita;

//Variables que reciben los cambios del DateTimePicker
DateTime _dateInput;
TimeOfDay _timeInput;

List<String> _formHintsCita = [
  "Escoja la especialidad",
  "Escoja la fecha de su cita",
  "Escoja la hora de la cita",
];

int idEspecialidad(){
  for (var i = 0; i < listaEspecialidades.length; i++) {
    if(_controlEspecialidad == listaEspecialidades[i]){
      return i+1;
    }
  }
}
void insertarCitaPerfil(){
  http.post(urlInsertarCita, body: {
    "dni": datosPersonales["dni"],
    "nombres": "",
    "apellidos":"",
    "correo": "",
    "celular": "",
    "sexo": "",
    "id_esp": idEspecialidad().toString(),
    "fecha_cita": _controlEnvioFecha,
    "hora_cita": _controlEnvioHora,
    "fecha_gen_cita": _controlEnvioGenCita,
  });
}

class CitasDentista extends StatefulWidget {

  final ValueChanged<int> state;

  const CitasDentista({this.state});

  @override
  _CitasDentistaState createState() => _CitasDentistaState();
}

double _alturaImagen = 250;
bool _vacio = false;


class _CitasDentistaState extends State<CitasDentista> {

  void _datePresent(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime(2022))
      .then((value){
        if(value == null){
        }else{
          setState(() {
            _dateInput = value;

            //Fecha que se verá en el formfield
            _controlFecha.text = _dateInput.day.toString() + "/" + _dateInput.month.toString() + "/" + _dateInput.year.toString();
            
            //Seteando la fecha a enviar en el formato de mysql
            _controlEnvioFecha = _dateInput.year.toString() + "-";
            _controlEnvioFecha += _dateInput.month.toString().length < 2
              ? "0" + _dateInput.month.toString()
              : _dateInput.month.toString();
            _controlEnvioFecha += "-";
            _controlEnvioFecha += _dateInput.day.toString().length < 2
              ? "0" + _dateInput.day.toString()
              : _dateInput.day.toString();

          });
        }
      });
  }

   void _timePresent(){
    showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),)
      .then((value){
        if(value == null){
        }else{
          setState(() {
            _timeInput = value;
            _controlHora.text = _timeInput.format(context);
            _controlEnvioHora = _timeInput.hour.toString() + ":" + _timeInput.minute.toString();
          });
        }
      });
  }

  void _dropDownEspecialidad(value){
    setState(() {
      _controlEspecialidad = value;
      print(_controlEspecialidad);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _header(),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: separador),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(roundedB),
                    color: Colors.white
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: SingleChildScrollView(child: TablaCitasDentista(state: widget.state))
                ),
                _formsCita()
              ],
            ),
          ],
        )
      ],
    );
  }
  Widget _formsCita(){
  return Container(
    width: 400,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyRText(
          text: "Crear Cita",
          tipo: "subtitleL",
          color: MyColors().colorOscuro(),
          bold: 7
        ),
        SizedBox(height: 10),
        Container(
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(roundedL)
          ),
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: Container(),
            dropdownColor: Colors.white,
            elevation: 0,
            items: listaEspecialidades
                .map<DropdownMenuItem<String>>(( value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: MyColors().colorOscuro(),
              fontWeight: FontWeight.w400
            ),
            value: _controlEspecialidad,
            hint: MyRText(
              text: _formHintsCita[0],
              tipo: "bodyL",
              color: MyColors().colorGris()
            ),
            onChanged: (String newValue) {
              _dropDownEspecialidad(newValue);
            },
          ),
        ),

        SizedBox(height: 10),
        MyRTextFormField(
          onTap: _datePresent,
          hintText: _formHintsCita[1],
          controller: _controlFecha,
          keyboardType: TextInputType.text,
          obscureText: false,
          formColor: Colors.white,
          textColor: MyColors().colorGris(),
        ),
        
        SizedBox(height: 10),
        MyRTextFormField(
          showCursor: false,
          onTap: _timePresent,
          hintText: _formHintsCita[2],
          controller: _controlHora,
          keyboardType: TextInputType.text,
          obscureText: false,
          formColor: Colors.white,
          textColor: MyColors().colorGris(),
        ),

        SizedBox(height: 20),
        MyRButton(
          onPressed: () {
            if(_controlEspecialidad == "" || _controlFecha.text == "" || _controlHora.text == ""){
              _vacio = true;
            }
            if(_vacio){
              rowAlert("Algunos campos estan vacíos, asegúrese de llenarlos todos", context);
              _vacio = false;
            }else{
              _controlEnvioGenCita = DateTime.now().toString();
              insertarCitaPerfil();
              setState(() {
                _controlHora.clear();
                _controlFecha.clear();
                _controlEspecialidad = null;
                _vacio = false;
              });
              rowAlert("La cita fue creada con éxito,", context, "Hecho");
            }
          },
          child: MyRText(
            text: "Confirmar",
            tipo: "bodyLL",
            color: Colors.white,
            bold: 5
          )
        )
      ],
    ),
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




class TablaCitasDentista extends StatefulWidget {

  final ValueChanged<int> state;

  const TablaCitasDentista({this.state});

  @override
  _TablaCitasDentistaState createState() => _TablaCitasDentistaState();
}

class _TablaCitasDentistaState extends State<TablaCitasDentista> {

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
      child: FutureBuilder(
        future: obtenerCitasLista() ,
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
                DataColumn(label: MyRText(text: "Nombre", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Especialidad", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Fecha", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Hora", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: MyRText(text: "Estado", tipo: "bodyL", color: MyColors().colorAzulMedio(), bold: 6)),
                DataColumn(label: Container(width: anchoSeparador, color: colorSeparador)),
              ],
              rows: [
                for (var i = 0; i < snapshot.data.length; i++)
                  DataRow(
                    onSelectChanged: (selected) {
                      if(selected){
                        rowSelected(int.parse(snapshot.data[i]["id_cita"]), selected);
                      }
                    },
                    cells: [
                      DataCell(Container(width: anchoSeparador, color: colorSeparador)),
                      DataCell(MyRText(text: "${snapshot.data[i]["nombres_usu"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${datosEspecialidades[int.parse(snapshot.data[i]["id_esp"])-1]["nombre"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[i]["fecha_cita"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[i]["hora_cita"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
                      DataCell(MyRText(text: "${snapshot.data[i]["estado_cita"]}", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)),
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
        MyRButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: MyRText(text: "Cancelar", tipo: "bodyLLL", color: Colors.white, bold: 5)
        ),
        MyROutlineButton(
          onPressed: () {
            borrarCita(indice);
            widget.state(1);
            setState(() {
              obtenerCitas(); 
            });
            Navigator.pop(context);
          },
          color: MyColors().colorOscuro(),
          child: MyRText(text: "Anular Cita", tipo: "bodyLLL", color: MyColors().colorOscuro(), bold: 5)
        ),
      ],
    );
  }
}