import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../myWidgets.dart';
import '../../mystyle.dart';
import '../datos.dart';
import 'package:http/http.dart' as http;

TextEditingController _controlNombre = new TextEditingController();
TextEditingController _controlCorreo = new TextEditingController();
String _controlSexo;
String _controlEspecialidad;
TextEditingController _controlApellidos = new TextEditingController();
TextEditingController _controlDni = new TextEditingController();
TextEditingController _controlCelular = new TextEditingController();
TextEditingController _controlFecha = new TextEditingController();
TextEditingController _controlHora = new TextEditingController();

String _controlEnvioFecha;
String _controlEnvioHora;
String _controlEnvioGenCita;
DateTime dateInput;
TimeOfDay timeInput;


List<String> formHintsCita = [
  "Nombres",
  "Correo Electrónico",
  "Sexo",
  "Escoja la especialidad",
  "Apellidos",
  "Dni",
  "Número Celular",
  "Escoja la fecha de su cita",
  "Escoja la hora de la cita",
];

List _formControllers = [
  _controlNombre,
  _controlCorreo,
  _controlApellidos,
  _controlDni,
  _controlCelular,
  _controlFecha,
  _controlHora,
];

bool vacio = false;

final urlInsertarCita = url + "insertarCita.php";

int idEspecialidad(){
  for (var i = 0; i < listaEspecialidades.length; i++) {
    if(_controlEspecialidad == listaEspecialidades[i]){
      return i+1;
    }
  }
}

void insertarCita() async{
  http.post(urlInsertarCita, body: {
    "dni": _controlDni.text,
    "nombres": _controlNombre.text,
    "apellidos": _controlApellidos.text,
    "correo": _controlCorreo.text,
    "celular": _controlCelular.text,
    "sexo": _controlSexo,
    "id_esp": idEspecialidad().toString(),
    "fecha_cita": _controlEnvioFecha,
    "hora_cita": _controlEnvioHora,
    "fecha_gen_cita": _controlEnvioGenCita,
  });
}

final double separaform = 14;

class CrearCita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //datos variables
    String textop ="Reservar tu cita es completamente gratis.";
    String creatext = "Creat tu cita";
    final toptext = new MyRText(
      textAlign: TextAlign.center,
      text: textop,
      color: MyColors().colorVerdeOscuro(),
      tipo: "bodyL",
      bold: 5,
    );
    final creacitatext = new MyRText(
      text: creatext,
      color: MyColors().colorOscuro(),
      bold: 7,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: new Size.fromHeight(sizeAppBar),
        child: MyRAppBar(
          tipo: rolGlobal,
        )
      ),
      body: Center(
        child: Container(
          width: 800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              toptext,
              creacitatext,
              new FormularioCita(),
              SizedBox(height: separaform*2),
              MyRButton(
                onPressed: (){
                  for (var i = 0; i < _formControllers.length; i++) {
                    if(_formControllers[i].text == ""){
                      vacio = true;
                    }
                  }
                  if(_controlSexo == "" && _controlEspecialidad == ""){
                    vacio = true;
                  }
                  if(vacio){
                    rowAlert("Algunos campos estan vacíos, asegúrese de llenarlos todos", context);
                  }else{
                    _controlEnvioGenCita = DateTime.now().toString();
                    insertarCita();
                    for (var i = 0; i < _formControllers.length; i++) {
                      _formControllers.clear();
                    }
                    _controlSexo = "";
                    _controlEspecialidad = "";
                    vacio = false;
                  }
                },
                child: MyRText(
                  text: "Crear Cita",
                  tipo: "buttonContent",
                  color: Colors.white,
                  bold: 6
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class FormularioCita extends StatefulWidget{
  @override
  _FormularioCitaState createState() => _FormularioCitaState();
}

class _FormularioCitaState extends State<FormularioCita> {

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
            dateInput = value;

            //Fecha que se verá en el formfield
            _controlFecha.text = dateInput.day.toString() + "/" + dateInput.month.toString() + "/" + dateInput.year.toString();
            
            //Seteando la fecha a enviar en el formato de mysql
            _controlEnvioFecha = dateInput.year.toString() + "-";
            _controlEnvioFecha += dateInput.month.toString().length < 2
              ? "0" + dateInput.month.toString()
              : dateInput.month.toString();
            _controlEnvioFecha += "-";
            _controlEnvioFecha += dateInput.day.toString().length < 2
              ? "0" + dateInput.day.toString()
              : dateInput.day.toString();

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
            timeInput = value;
            _controlHora.text = timeInput.format(context);
            _controlEnvioHora = timeInput.hour.toString() + ":" + timeInput.minute.toString();
          });
        }
      });
  }
  
  void dropDownSexo(value){
    setState(() {
      _controlSexo = value;
    });
  }
  void dropDownEspecialidad(value){
    setState(() {
      _controlEspecialidad = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Nombre
                MyRTextFormField(
                  hintText: formHintsCita[0],
                  controller: _controlNombre,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  formColor: MyColors().colorGrisClaro(),
                  textColor: MyColors().colorGris(),
                ),
                SizedBox(height: separaform),
                
                //Correo
                MyRTextFormField(
                  hintText: formHintsCita[1],
                  controller: _controlCorreo,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  formColor: MyColors().colorGrisClaro(),
                  textColor: MyColors().colorGris(),
                ),
                SizedBox(height: separaform),
                
                //Sexo
                Center(
                  child: DropdownButton<String>(
                    dropdownColor: MyColors().colorGrisClaro(),
                    elevation: 0,
                    items: <String>['Masculino', 'Femenino']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: MyColors().colorOscuro(),
                      fontWeight: FontWeight.w400
                    ),
                    value: _controlSexo,
                    hint: MyRText(
                      text: formHintsCita[2],
                      tipo: "bodyLL",
                      color: MyColors().colorGris()
                    ),
                    onChanged: (String newValue) {
                      dropDownSexo(newValue);
                    },
                  ),
                ),
                SizedBox(height: separaform),

                //Especialidad
                Center(
                  child: DropdownButton<String>(
                    dropdownColor: MyColors().colorGrisClaro(),
                    elevation: 0,
                    items: listaEspecialidades
                        .map<DropdownMenuItem<String>>(( value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: MyColors().colorOscuro(),
                      fontWeight: FontWeight.w400
                    ),
                    value: _controlEspecialidad,
                    hint: MyRText(
                      text: formHintsCita[3],
                      tipo: "bodyLL",
                      color: MyColors().colorGris()
                    ),
                    onChanged: (String newValue) {
                      dropDownEspecialidad(newValue);
                    },
                  ),
                ),
                SizedBox(height: separaform),
              ],          
            ),
          ),
          SizedBox(width: separaform),
          Container(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                //Apellidos
                MyRTextFormField(
                  hintText:formHintsCita[4] ,
                  controller: _controlApellidos,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  formColor: MyColors().colorGrisClaro(),
                  textColor: MyColors().colorGris(),
                ),
                SizedBox(height: separaform),

                //Dni y celular
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[

                        //Dni
                        Container(
                          width: (constraints.maxWidth/2 - separaform/2),
                          child: MyRTextFormField(
                            hintText: formHintsCita[5],
                            controller: _controlDni,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            formColor: MyColors().colorGrisClaro(),
                            textColor: MyColors().colorGris(),
                          ),
                        ),
                        SizedBox(height: separaform),

                        //Celular
                        Container(
                          width: (constraints.maxWidth/2 - separaform/2),
                          child: MyRTextFormField(
                            hintText: formHintsCita[6],
                            controller: _controlCelular,
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            formColor: MyColors().colorGrisClaro(),
                            textColor: MyColors().colorGris(),
                          ),
                        ),
                      ] 
                    );
                  }
                ),
                SizedBox(height: separaform),
                MyRTextFormField(
                  onTap: _datePresent,
                  hintText: formHintsCita[7],
                  controller: _controlFecha,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  formColor: MyColors().colorGrisClaro(),
                  textColor: MyColors().colorGris(),
                ),
                SizedBox(height: separaform),
                MyRTextFormField(
                  onTap: _timePresent,
                  hintText: formHintsCita[8],
                  controller: _controlHora,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  formColor: MyColors().colorGrisClaro(),
                  textColor: MyColors().colorGris(),
                ),
              ],
            ),
          )  
        ],
      )
    );
  }
}